 import 'dart:ffi';

 import 'package:cloud_firestore/cloud_firestore.dart';

 class bukuBarter{
   final String Judul;
   final String Penerbit;
   final String ISBN;
   final String Kategori;
   final String Gambar;

   bukuBarter({
     required this.Judul,
     required this.Penerbit,
     required this.ISBN,
     required this.Kategori,
     required this.Gambar
 });

   factory bukuBarter.fromFirestore(DocumentSnapshot doc) {
     final data = doc.data() as Map<String, dynamic>;

     return bukuBarter(
       Judul: data['Judul'],
       Penerbit: data['Penerbit'],
       ISBN: data['ISBN'],
       Kategori: data['Kategori'],
       Gambar: data['Gambar'],
     );
   }

   bukuBarter copyWith({
     String? Judul,
     String? Penerbit,
     String? ISBN,
     String? Kategori,
     String? Gambar,
 }) {
     return bukuBarter(
       Judul: Judul ?? this.Judul,
       Penerbit: Penerbit ?? this.Penerbit,
       ISBN: ISBN ?? this.ISBN,
       Kategori: Kategori ?? this.Kategori,
       Gambar: Gambar ?? this.Gambar,
     );
   }
 }