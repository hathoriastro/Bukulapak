import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/product_card.dart';
import 'package:bukulapak/model/favoriteProduct_model.dart';
import 'package:bukulapak/services/tambahproduk_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FavoritProfilePage extends StatefulWidget {
  const FavoritProfilePage({super.key});

  @override
  State<FavoritProfilePage> createState() => _FavoritProfilePageState();
}

class _FavoritProfilePageState extends State<FavoritProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullwidth = 440;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: sizeheight * 0.12,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 10, right: 17, top: 27),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back),
              ),
              Text(
                'Favorit',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: orange,
                ),
              ),
              SizedBox(width: sizewidth * 0.1),
            ],
          ),
        ),
      ),


      body: StreamBuilder<List<FavoriteproductModel>>(
        stream: TambahprodukService().getFavoriteProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada produk favorit"));
          }

          final produkList = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 5,
              mainAxisSpacing: 15,
            ),
            itemCount: produkList.length,
            itemBuilder: (context, index) {
              final produk = produkList[index];

              return ProductCard(
                imageProduct: produk.Gambar,
                date: produk.tanggal,
                time: produk.jam,
                price: produk.Harga,
                location: produk.location,
                title: produk.Judul,
                kategori: produk.kategori,
                deskripsi: produk.deskripsi,
              );
            },
          );
        },
      ),
    );
  }
}
