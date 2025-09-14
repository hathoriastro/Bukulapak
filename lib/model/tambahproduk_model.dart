import 'package:cloud_firestore/cloud_firestore.dart';

class TambahprodukModel {
  final String Judul;
  final String Penerbit;
  final String ISBN;
  final String Kategori;
  final String Gambar;
  final String Video;
  final String Harga;
  final String Deskripsi;
  final Timestamp? timestamp;

  TambahprodukModel({
    required this.Judul,
    required this.Penerbit,
    required this.ISBN,
    required this.Kategori,
    required this.Gambar,
    required this.Video,
    required this.Harga,
    required this.Deskripsi,
    required this.timestamp,
  });

  /// ambil data value dari firestore
  factory TambahprodukModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return TambahprodukModel(
      Judul: data['judul'] ?? '',
      Penerbit: data['penerbit'] ?? '',
      ISBN: data['isbn'] ?? '',
      Kategori: data['kategori'] ?? '',
      Gambar: data['gambar'] ?? '',
      Video: data['video'] ?? '',
      Harga: data['harga'] ?? 'gratis',
      Deskripsi: data['deskripsi'] ?? '',
      timestamp: data['timestamp'],
    );
  }

  //svae data value di firestore
  Map<String, dynamic> toMap() {
    return {
      'judul': Judul,
      'penerbit': Penerbit,
      'isbn': ISBN,
      'kategori': Kategori,
      'gambar': Gambar,
      'video': Video,
      'harga': Harga,
      'deskripsi': Deskripsi,
      'timestamp': timestamp,
    };
  }
}
