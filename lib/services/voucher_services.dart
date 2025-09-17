import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VoucherServices {
  String generateVoucher() {
    final random = DateTime.now().millisecondsSinceEpoch;
    return "QUIZ30-${random.toString().substring(random.toString().length - 4)}";
  }

  Future<void> saveVoucher(String code) async {
    FirebaseFirestore.instance
        .collection('voucher')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'code': code,
      'discount': 0.3,
    });
  }

  Future<num> applyVoucher({
    required String code,
    required String productID,
  }) async {
    try {
      print("=== START APPLY VOUCHER ===");
      print("Code: $code");
      print("Product ID: $productID");

      // 1. Cek voucher ada atau tidak
      final voucherSnap = await FirebaseFirestore.instance
          .collection('voucher')
          .where('code', isEqualTo: code)
          .limit(1)
          .get();

      if (voucherSnap.docs.isEmpty) {
        print("Voucher tidak ditemukan");
        throw Exception('Kode voucher tidak valid');
      }

      final discount = (voucherSnap.docs.first.data()['discount'] ?? 0).toDouble();
      print("Discount found: $discount");

      // 2. Cari produk dengan cara yang lebih spesifik
      // Opsi 1: Cari di collection user spesifik
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId == null) {
        throw Exception('User tidak login');
      }

      // Coba cari di path spesifik user dulu
      QuerySnapshot productSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('tambah_keranjang')
          .where('judul', isEqualTo: productID)
          .limit(1)
          .get();

      // Jika tidak ketemu, coba dengan collectionGroup
      if (productSnap.docs.isEmpty) {
        print("Tidak ketemu di user collection, coba collectionGroup...");
        productSnap = await FirebaseFirestore.instance
            .collectionGroup('tambah_keranjang')
            .where('judul', isEqualTo: productID)
            .limit(1)
            .get();
      }

      if (productSnap.docs.isEmpty) {
        print("Produk tidak ditemukan di manapun");
        throw Exception('Produk tidak ditemukan dalam keranjang');
      }

      print("=== PRODUK DITEMUKAN ===");
      print("Jumlah dokumen: ${productSnap.docs.length}");

      final productDoc = productSnap.docs.first;
      final productData = productDoc.data() as Map<String, dynamic>;
      final productRef = productDoc.reference;

      print("Document ID: ${productDoc.id}");
      print("Document path: ${productRef.path}");
      print("Data produk: $productData");

      // 3. Parse harga dengan lebih robust
      double parsePrice(dynamic value) {
        print("Parsing harga: $value (type: ${value.runtimeType})");

        if (value == null) return 0.0;

        if (value is num) {
          print("Harga adalah number: ${value.toDouble()}");
          return value.toDouble();
        }

        if (value is String) {
          // Handle case "gratis" atau "free"
          if (value.toLowerCase().contains('gratis') ||
              value.toLowerCase().contains('free')) {
            print("Harga gratis");
            return 0.0;
          }

          // Clean string untuk mendapatkan angka
          final clean = value
              .replaceAll(RegExp(r'[^\d]'), '') // hapus semua selain digit
              .trim();

          if (clean.isEmpty) return 0.0;

          final parsed = double.tryParse(clean) ?? 0.0;
          print("String '$value' -> cleaned '$clean' -> parsed: $parsed");
          return parsed;
        }

        print("Tidak bisa parse harga, return 0");
        return 0.0;
      }

      final currentPrice = parsePrice(productData['harga']);
      print("Harga sekarang: $currentPrice");

      if (currentPrice <= 0) {
        throw Exception('Harga produk tidak valid');
      }

      // 4. Hitung harga baru
      final newPrice = (currentPrice * (1 - discount)).clamp(0, double.infinity);
      final newPriceRounded = newPrice.round(); // Bulatkan untuk konsistensi

      print("Harga baru: $newPrice -> dibulatkan: $newPriceRounded");

      // 5. Update di Firestore
      print("Updating Firestore...");
      await productRef.update({
        'harga': newPriceRounded.toString(), // Simpan sebagai string jika format aslinya string
        'original_price': currentPrice, // Simpan harga asli untuk referensi
        'discount_applied': discount,
        'voucher_code': code,
        'updated_at': FieldValue.serverTimestamp(),
      });

      print("Firestore berhasil diupdate!");
      print("=== END APPLY VOUCHER ===");

      return newPriceRounded;

    } catch (e) {
      print("ERROR di applyVoucher: $e");
      print("Stack trace: ${StackTrace.current}");
      rethrow; // Lempar ulang error agar bisa ditangkap di UI
    }
  }

  // Method helper untuk reset harga produk (jika diperlukan)
  Future<void> resetProductPrice({
    required String productID,
  }) async {
    try {
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId == null) return;

      final productSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('tambah_keranjang')
          .where('judul', isEqualTo: productID)
          .limit(1)
          .get();

      if (productSnap.docs.isNotEmpty) {
        final productDoc = productSnap.docs.first;
        final productData = productDoc.data();

        if (productData['original_price'] != null) {
          await productDoc.reference.update({
            'harga': productData['original_price'].toString(),
            'original_price': FieldValue.delete(),
            'discount_applied': FieldValue.delete(),
            'voucher_code': FieldValue.delete(),
            'updated_at': FieldValue.serverTimestamp(),
          });
        }
      }
    } catch (e) {
      print("Error reset price: $e");
    }
  }
}