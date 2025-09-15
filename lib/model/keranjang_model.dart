import 'package:cloud_firestore/cloud_firestore.dart';

class KeranjangModel {
  final String judul;
  final String gambar;
  final String harga;
  final String kategori;
   final String id;

  KeranjangModel({
    required this.judul,
    required this.gambar,
    required this.harga,
    required this.kategori,required this.id
  });


  factory KeranjangModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return KeranjangModel(
      judul: data['judul'] ?? '',
      gambar: data['gambar'] ?? '',
      kategori: data['kategori'],
      harga: data['harga'] ?? 'GRATIS',
      id: doc.id,
    );
  }


 Map<String, dynamic> toMap() {
  return {
    'judul': judul,
    'gambar': gambar,
    'harga': harga,
    'kategori': kategori,
  };
}

}
