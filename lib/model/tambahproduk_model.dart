import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TambahprodukModel {
  final String Judul;
  final String Penerbit;
  final String ISBN;
  final String KategoriBuku;
  final String KategoriJual;
  final String Gambar;
  final String Video;
  final String Harga;
  final String Deskripsi;
  final Timestamp? timestamp;
  final bool isCheckout; 
  final String ownerId;
  TambahprodukModel({
    required this.Judul,
    required this.Penerbit,
    required this.ISBN,
    required this.KategoriBuku,
    required this.KategoriJual,
    required this.Gambar,
    required this.Video,
    required this.Harga,
    required this.Deskripsi,
    required this.timestamp,
    this.isCheckout = false,
    required this.ownerId
  });

  /// ambil data value dari firestore
  factory TambahprodukModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final User? user = FirebaseAuth.instance.currentUser;
final String uid = user?.uid ?? '';

    return TambahprodukModel(
      Judul: data['judul'] ?? '',
      Penerbit: data['penerbit'] ?? '',
      ISBN: data['isbn'] ?? '',
      KategoriBuku: data['kategoriBuku'] ?? data['kategori'] ?? '',
      KategoriJual: data['kategoriJual'] ?? '',
      Gambar: data['gambar'] ?? '',
      Video: data['video'] ?? '',
      Harga: data['harga'] ?? 'gratis',
      Deskripsi: data['deskripsi'] ?? '',
      timestamp: data['timestamp'],
       isCheckout: data['isCheckout'] ?? false,
       ownerId: data['ownerId'] ?? '',
    );
  }

  //svae data value di firestore
  Map<String, dynamic> toMap() {
    return {
      'judul': Judul,
      'penerbit': Penerbit,
      'isbn': ISBN,
      'kategoriBuku': KategoriBuku,
      'kategoriJual': KategoriJual,
      'gambar': Gambar,
      'video': Video,
      'harga': Harga,
      'deskripsi': Deskripsi,
      'timestamp': timestamp,
      'isCheckout' : isCheckout,
      'ownerId' : ownerId
    };
  }
}
