import 'package:cloud_firestore/cloud_firestore.dart';

class TambahprodukModel{
  final String Judul;
  final String Penerbit;
  final String ISBN;
  final String Kategori;
  final String Gambar;
  final String Video;
  final String Harga;
  final String Deskripsi;

  TambahprodukModel({
    required this.Judul,
    required this.Penerbit,
    required this.ISBN,
    required this.Kategori,
    required this.Gambar,
    required this.Video,
    required this.Harga,
    required this.Deskripsi
});

  factory TambahprodukModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return TambahprodukModel(
      Judul: data['Judul'],
      Penerbit: data['Penerbit'],
      ISBN: data['ISBN'],
      Kategori: data['Kategori'],
      Gambar: data['Gambar'],
      Video: data['Video'],
      Harga: data['Harga'],
      Deskripsi: data['Deskripsi']
    );
  }

  TambahprodukModel copyWith({
    String? Judul,
    String? Penerbit,
    String? ISBN,
    String? Kategori,
    String? Gambar,
    String? Video,
    String? Harga,
    String? Deskripsi,
}) {
    return TambahprodukModel(
      Judul: Judul ?? this.Judul,
      Penerbit: Penerbit ?? this.Penerbit,
      ISBN: ISBN ?? this.ISBN,
      Kategori: Kategori ?? this.Kategori,
      Gambar: Gambar ?? this.Gambar,
      Video: Video?? this.Video,
      Harga: Harga?? this.Harga,
      Deskripsi: Deskripsi?? this.Deskripsi
    );
  }
}