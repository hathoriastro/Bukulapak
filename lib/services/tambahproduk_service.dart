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
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('tambah_produk')
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
        .collectionGroup('produk')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => TambahprodukModel.fromFirestore(doc))
              .toList();
        });
  }
}
