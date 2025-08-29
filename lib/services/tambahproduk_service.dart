
import 'package:bukulapak/model/tambahproduk_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TambahprodukService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  Future<void> addProduct(TambahprodukModel add_product) async {
  try {
    final docRef = _firestore
        .collection('user')
        .doc(_firebaseAuth.currentUser?.uid)
        .collection('tambah_produk')
        .doc(); 

    final data = {
      'id': _firebaseAuth.currentUser?.uid,
      'judul': add_product.Judul,
      'penerbit': add_product.Penerbit,
      'isbn': add_product.ISBN,
      'kategori': add_product.Kategori,
      'harga': add_product.Harga,
      'gambar': add_product.Gambar,
      'video' : add_product.Video,
      'deskripsi': add_product.Deskripsi,
      'timestamp': FieldValue.serverTimestamp(),
    };

    final docSnapshot = await docRef.get();
      if(docSnapshot.exists){
        await docRef.update(data);
      } else {
        await docRef.set(data);
      }
  } catch (e) {
    print('Error menambah produk: $e');
  }
}

final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<TambahprodukModel>> getProduk() async {
    try {
      final snapshot = await _db.collection('tambah_produk').get();

      return snapshot.docs
          .map((doc) => TambahprodukModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}