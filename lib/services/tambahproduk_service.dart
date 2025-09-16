import 'package:bukulapak/model/favoriteProduct_model.dart';
import 'package:bukulapak/model/keranjang_model.dart';
import 'package:bukulapak/model/tambahproduk_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TambahprodukService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  
  Future<void> addProduct(TambahprodukModel addProduct) async {
    try {
      final docRef = _firestore
          .collection('user')
          .doc(_firebaseAuth.currentUser?.uid)
          .collection('tambah_produk')
          .doc();

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        
        await docRef.update(addProduct.toMap());
      } else {
        //timestamp
        await docRef.set({
          ...addProduct.toMap(),
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error menambah produk: $e');
    }
  }


  Future<void> addProductAll(TambahprodukModel addProduct) async {
    try {
      final docRef = _firestore
          .collection('produk')
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

   
  Stream<List<TambahprodukModel>> getProdukByUser() {
  return _firestore
      .collection('user')
      .doc(_firebaseAuth.currentUser?.uid) // ← Dokumen sesuai UID user login
      .collection('tambah_produk')         // ← Subkoleksi produk user itu saja
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs
            .map((doc) => TambahprodukModel.fromFirestore(doc))
            .toList();
      });
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
    Future<void> addKeranjang(KeranjangModel addProduct) async {
  try {
    final docRef = _firestore
        .collection('user')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('tambah_keranjang')
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


  Future<void> removeKeranjang(String id) async {
    final userId = _firebaseAuth.currentUser!.uid;

    await _firestore
        .collection('user')
        .doc(userId)
        .collection('tambah_keranjang')
        .doc(id)
        .delete();
  }

  // stream keranjang biar UI auto refresh
  Stream<List<KeranjangModel>> getKeranjang() {
    final userId = _firebaseAuth.currentUser!.uid;
    return _firestore
        .collection('user')
        .doc(userId)
        .collection('tambah_keranjang')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => KeranjangModel.fromFirestore(doc)).toList());
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

}

