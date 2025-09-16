import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/product_card.dart';
import 'package:bukulapak/model/tambahproduk_model.dart';
import 'package:bukulapak/services/tambahproduk_service.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListBooks extends StatefulWidget {
  final int currentindex;
  const ListBooks({super.key, required this.currentindex});

  @override
  State<ListBooks> createState() => _ListBooksState();
}

class _ListBooksState extends State<ListBooks>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> text = ["Berbayar", "Gratis"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: text.length,
      vsync: this,
      initialIndex: widget.currentindex,
    );
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final fullwidth = 440;

    Widget buildGrid(String kategori) {
      return StreamBuilder<List<TambahprodukModel>>(
        stream: TambahprodukService().getAllProduk(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo_bukulapak.png'),
                  SizedBox(height: 10),
                  Text(
                    'Buku Belum Tersedia ..',
                    style: TextStyle(color: lightGray, fontSize: 16),
                  )
                ],
              ),
            );
          }

          // Filter sesuai tab
          final produkList = snapshot.data!.where((produk) {
  if (kategori.toLowerCase() == 'gratis') {
    return produk.Harga == '0' || produk.Harga.isEmpty;
  } else {
    return produk.Harga != '0' && produk.Harga.isNotEmpty;
  }
}).toList();

          // final produkList = snapshot.data!
          //     .where((produk) =>
          //         produk.KategoriJual.toLowerCase() == kategori.toLowerCase())
          //     .toList();

          // if (produkList.isEmpty) {
          //   return Center(
          //     child: Text(
          //       "Belum ada produk $kategori",
          //       style: TextStyle(color: lightGray, fontSize: 16),
          //     ),
          //   );
          // }

          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (sizewidth * 186 / fullwidth) / 215,
              crossAxisSpacing: 5,
              mainAxisSpacing: 15,
            ),
            padding: EdgeInsets.only(left: 24, right: 8, bottom: 15),
            itemCount: produkList.length,
            itemBuilder: (context, index) {
              final produk = produkList[index];
              return ProductCard(
                imageProduct: produk.Gambar,
                date: produk.timestamp != null
                    ? DateFormat('dd-MM-yyyy')
                        .format(produk.timestamp!.toDate())
                    : 'Tanggal Kosong',
                time: produk.timestamp != null
                    ? DateFormat('HH:mm').format(produk.timestamp!.toDate())
                    : 'Jam Kosong',
                price: kategori.toLowerCase() == 'gratis'
                    ? 'Gratis'
                    : 'Rp.${produk.Harga}',
                location: "Malang",
                title: produk.Judul,
                deskripsi: produk.Deskripsi,
                kategori: produk.KategoriBuku,
              );
            },
          );
        },
      );
    }

    return DefaultTabController(
      length: text.length,
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonsTabBar(
              controller: _tabController,
              backgroundColor: lightBlue,
              contentCenter: true,
              width: sizewidth * 182 / fullwidth,
              height: 41,
              unselectedBackgroundColor: Colors.transparent,
              unselectedLabelStyle: TextStyle(
                color: lightBlue,
                fontWeight: FontWeight.w800,
                fontSize: 24,
              ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              borderWidth: 1,
              unselectedBorderColor: lightBlue,
              radius: 20,
              tabs: List.generate(
                text.length,
                (index) => Tab(
                  child: Text(
                    text[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: _tabController.index == index
                          ? Colors.white
                          : lightBlue,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  buildGrid("berbayar"),
                  buildGrid("gratis"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
