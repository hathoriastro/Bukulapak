import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteproductModel {
  final String Judul;
  final String Gambar;
  final String Harga;
  final String jam;
  final String tanggal;
  final String location;
  final String deskripsi;
  final String kategori;

  FavoriteproductModel({
    required this.Judul,
    required this.Gambar,
    required this.Harga,
    required this.jam,
    required this.location,
    required this.deskripsi,
    required this.kategori,
    required this.tanggal
  });


  factory FavoriteproductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return FavoriteproductModel(
      Judul: data['judul'] ?? '',
      jam: data['jam'] ?? '',
      tanggal: data['tanggal'] ?? '',
      Gambar: data['gambar'] ?? '',
      Harga: data['harga'] ?? 'GRATIS',
      location: data['lokasi'] ?? 'Malang',
      deskripsi: data['deskripsi'],
      kategori: data['kategori'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'judul': Judul,
      'jam': jam,
      'tanggal' : tanggal,
      'gambar': Gambar,
      'harga': Harga,
      'lokasi': location,
      'deskripsi': deskripsi,
      'kategori': kategori,
    };
  }
}
