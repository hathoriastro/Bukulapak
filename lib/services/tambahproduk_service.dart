import 'package:bukulapak/model/favoriteProduct_model.dart';
import 'package:bukulapak/model/keranjang_model.dart';
import 'package:bukulapak/model/tambahproduk_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TambahprodukService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future<String?> addProduct(TambahprodukModel addProduct) async {
    try {
      // Generate ID di collection produk
      final docRef = _firestore.collection('produk').doc();
      final String productId = docRef.id;

      final data = {
        ...addProduct.toMap(),
        'id': productId,
        'timestamp': FieldValue.serverTimestamp(),
      };

      await docRef.set(data);

      return productId; // kembalikan id produk untuk dipakai di keranjang
    } catch (e) {
      print('Error menambah produk: $e');
      return null;
    }
  }

  Future<void> addProductAll(TambahprodukModel addProduct) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final userId = currentUser.uid;
    final userDoc = await _firestore.collection('user').doc(userId).get();
    final lokasiUser = userDoc.data()?['provinsi'] ?? '';

    try {

      await _firestore.collection('produk').add({
        ...addProduct.toMap(),
        'ownerId': userId,
        'lokasi_penjual': lokasiUser,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error menambah produk: $e');
    }
  }

  Future<void> addKeranjang(KeranjangModel addProduct) async {
    try {
      final docRef = _firestore
          .collection('user')
          .doc(_firebaseAuth.currentUser?.uid)
          .collection('tambah_keranjang')
          .doc(); // auto generate id keranjang

      await docRef.set({
        'id': docRef.id, // id keranjang
        ...addProduct.toMap(),
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error menambah keranjang: $e');
    }
  }

   
Stream<List<TambahprodukModel>> getProdukByUser() {
  final user = FirebaseAuth.instance.currentUser;

  return _firestore
      .collection('produk') // koleksi produk semua user
      .where('ownerId', isEqualTo: user?.uid) // filter hanya produk user ini
      // .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => TambahprodukModel.fromFirestore(doc)).toList());
}



  


  Stream<List<TambahprodukModel>> getAllProduk() {
    return _firestore
        .collection('produk')
        .where( "isCheckout", isEqualTo: false)
        // .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => TambahprodukModel.fromFirestore(doc))
              .toList();
        });
  }

  Stream<List<TambahprodukModel>> getAllProdukbyCategory() {
    return _firestore
        .collection('produk')
        .where('harga', isEqualTo: "",)
        .where('isCheckout', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TambahprodukModel.fromFirestore(doc))
          .toList();
    });
  }

  Future<void>addFavoriteProduct (FavoriteproductModel addProduct) async {
    try {
      final docRef = _firestore
          .collection('user')
          .doc(_firebaseAuth.currentUser?.uid)
          .collection('favorite')
          .doc();

    final docSnapshot = await docRef.get();

    if (docSnapshot.exists) {

      await docRef.update(addProduct.toMap());
    } else {
      await docRef.set({
        ...addProduct.toMap(),
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  } catch (e) {
  print('Error menambah produk: $e');
       }
    }

    Stream<List<FavoriteproductModel>> getFavoriteProduct() {
    return _firestore
        .collection('user')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('favorite')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => FavoriteproductModel.fromFirestore(doc))
              .toList();
        });
    }




    //KERANJANG


  Future<void> removeKeranjang(String keranjangId) async {
    try {
      final userId = _firebaseAuth.currentUser?.uid;
      if (userId == null) return;

      await _firestore
          .collection('user')
          .doc(userId)
          .collection('tambah_keranjang')
          .doc(keranjangId) // id dokumen keranjang
          .delete();
    } catch (e) {
      print('Error menghapus keranjang: $e');
    }
  }


  Stream<List<KeranjangModel>> getKeranjang() {
  final userId = _firebaseAuth.currentUser?.uid;
  if (userId == null) return const Stream.empty();

  return _firestore
      .collection('user')
      .doc(userId)
      .collection('tambah_keranjang')
      .where('isCheckout', isEqualTo: false)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => KeranjangModel.fromFirestore(doc)).toList());
}

  

  // --- Update isCheckout di keranjang user berdasarkan document id
  Future<void> updateCheckoutInKeranjangById(String docId, bool status) async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId == null) return;

  final docRef = FirebaseFirestore.instance
      .collection('user')
      .doc(userId)
      .collection('tambah_keranjang')
      .doc(docId);

  await docRef.update({'isCheckout': status});
}



Future<bool> checkKeranjang(String judul) async {
  final userId = _firebaseAuth.currentUser!.uid;

  final query = await _firestore
      .collection('user')
      .doc(userId)
      .collection('tambah_keranjang')
      .where('judul', isEqualTo: judul)
      .get();

  return query.docs.isNotEmpty; // true kalau sudah ada
}

Future<void> updateCheckoutByJudul(String judul, bool status) async {
  // misalnya kamu pakai Firestore:
  final query = await FirebaseFirestore.instance
      .collection('produk')
      .where('judul', isEqualTo: judul)
      .get();

  for (var doc in query.docs) {
    await doc.reference.update({'isCheckout': status});
  }
}

  Future<void> checkoutByProductId(String productId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final query = await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('tambah_keranjang')
        .where('productId', isEqualTo: productId)
        .get();

    for (var doc in query.docs) {
      await doc.reference.update({'isCheckout': true});
    }
  }

}

