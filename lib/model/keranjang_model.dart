import 'package:cloud_firestore/cloud_firestore.dart';

class KeranjangModel {
  final String? id;          // idKeranjang
  final String productId;   // id produk asli
  final String judul;
  final String gambar;
  final String harga;
  final String kategori;
  final bool isCheckout;

  KeranjangModel({
    this.id,
    required this.productId,
    required this.judul,
    required this.gambar,
    required this.harga,
    required this.kategori,
    required this.isCheckout,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'judul': judul,
      'gambar': gambar,
      'harga': harga,
      'kategori': kategori,
      'isCheckout': isCheckout,
    };
  }

  factory KeranjangModel.fromFirestore(DocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>;
  return KeranjangModel(
    id: doc.id, // ID dokumen keranjang
    productId: data['productId'] ?? '',
    judul: data['judul'] ?? '',
    gambar: data['gambar'] ?? '',
    harga: data['harga'] ?? '',
    kategori: data['kategori'] ?? '',
    isCheckout: data['isCheckout'] ?? false,
  );
}

}
