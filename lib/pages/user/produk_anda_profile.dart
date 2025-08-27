import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/produk_anda_card.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: const [
            ProdukAndaCard(
              coverbook: 'assets/images/logo_bukulapak.png',
              text1: 'Buku 1',
              text2: 'Penulis A',
              price: 'Rp50.000',
            ),
            ProdukAndaCard(
              coverbook: 'assets/images/logo_bukulapak.png',
              text1: 'Buku 2',
              text2: 'Penulis B',
              price: 'Rp60.000',
            ),
            ProdukAndaCard(
              coverbook: 'assets/images/logo_bukulapak.png',
              text1: 'Buku 3',
              text2: 'Penulis C',
              price: 'Rp70.000',
            ),
            ProdukAndaCard(
              coverbook: 'assets/images/logo_bukulapak.png',
              text1: 'Buku 4',
              text2: 'Penulis D',
              price: 'Rp80.000',
            ),
            ProdukAndaCard(
              coverbook: 'assets/images/logo_bukulapak.png',
              text1: 'Buku 5',
              text2: 'Penulis E',
              price: 'Rp90.000',
            ),
          ],
        ),
      ),
    );
  }
}
