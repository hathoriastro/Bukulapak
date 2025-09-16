import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/produk_anda_card.dart';
import 'package:bukulapak/model/tambahproduk_model.dart';
import 'package:bukulapak/services/tambahproduk_service.dart';
import 'package:flutter/material.dart';

class ProdukAndaProfilePage extends StatelessWidget {
  const ProdukAndaProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizeheight = size.height;
    final fullheight = 956;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: sizeheight * 0.1,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 40),
          child: Text(
            'Produk Anda',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: darkBlue,
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder<List<TambahprodukModel>>(
          stream: TambahprodukService().getProdukByUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(
                height: 190,
                child: Center(
                  child: Text("Anda Belum Menjual Buku"),
                ),
              );
            }

            final produkList = snapshot.data!;

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                children: produkList.map((produk) {
                  return ProdukAndaCardVertical(
                    coverbook: produk.Gambar,
                    text1: produk.Judul,
                    text2: produk.Kategori,
                    price: 'Rp${produk.Harga}',
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
