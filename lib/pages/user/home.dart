import 'package:bukulapak/components/user/banner_carousel.dart';
import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/product_card.dart';
import 'package:bukulapak/components/user/navbar.dart';
import 'package:bukulapak/components/user/product_cart.dart';
import 'package:bukulapak/model/tambahproduk_model.dart';
import 'package:bukulapak/pages/user/category_page.dart';
import 'package:bukulapak/pages/user/list_product_page.dart';
import 'package:bukulapak/services/tambahproduk_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullheight = 956;
    final fullwidth = 440;
    final uid = FirebaseAuth.instance.currentUser!.uid;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: sizeheight * 112 / fullheight,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        title: SizedBox(
          height: 42,
          width: sizewidth * 259 / fullwidth,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryPage()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Search",
                      style: TextStyle(color: lightGray, fontSize: 14),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ),
          ),
        ),

        actions: [
          ShoppingCart(),
          SizedBox(width: 38),
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: Image.asset('assets/images/logo_bukulapak.png', width: 28),
          ),
        ],
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03,
              bottom: MediaQuery.of(context).size.height * 0.03,
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: BannerCarousel(),
                ),
                SizedBox(height: 15),

                Container(
                  padding: EdgeInsets.only(left: 13),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.035,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Buku',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 4),
                            Column(
                              children: [
                                Text(
                                  'Gratis',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: customorange,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  height: 1.5,
                                  width: 65,
                                  color: darkBlue,
                                ),
                              ],
                            ),
                            Spacer(flex: 2),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ListProductPage(currentIndx: 1),
                                  ),
                                );
                              },
                              child: Text(
                                'Lihat Semua',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: lightGray,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15),
                       SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: StreamBuilder<List<TambahprodukModel>>(
                          stream: TambahprodukService().getAllProdukbyCategory(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Row(
                                children: [CircularProgressIndicator()],
                              );
                            }

                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Container(
                                height: 190,
                                child: Center(
                                  child: Row(
                                    children: [Text("Belum ada produk")],
                                  ),
                                ),
                              );
                            }

                            final produkList = snapshot.data!;

                            return Row(
                              children: produkList.map((produk) {
                                return ProductCard(
                                  imageProduct: produk.Gambar,
                                  date: produk.timestamp != null
                                      ? DateFormat(
                                          'dd-MM-yyyy',
                                        ).format(produk.timestamp!.toDate())
                                      : 'Tanggal Kosong',
                                  time: produk.timestamp != null
                                      ? DateFormat(
                                          'HH:mm',
                                        ).format(produk.timestamp!.toDate())
                                      : 'Jam Kosong',
                                  price:'GRATIS',
                                  location: produk.lokasiPenjual?? '',
                                  title: produk.Judul,
                                  kategori: produk.KategoriBuku,
                                  deskripsi: produk.Deskripsi,
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 40),
                      Padding(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.035,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Baru',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 4),
                            Column(
                              children: [
                                Text(
                                  'Ditambahkan',
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: darkBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  height: 1.5,
                                  width: 152,
                                  color: customorange,
                                ),
                              ],
                            ),

                            Spacer(flex: 2),
                            Text(
                              'Lihat Semua',
                              style: TextStyle(
                                fontSize: 8,
                                color: lightGray,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: StreamBuilder<List<TambahprodukModel>>(
                          stream: TambahprodukService().getAllProduk(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Row(
                                children: [CircularProgressIndicator()],
                              );
                            }

                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Container(
                                height: 190,
                                child: Center(
                                  child: Row(
                                    children: [Text("Belum ada produk")],
                                  ),
                                ),
                              );
                            }

                            final produkList = snapshot.data!;

                            return Row(
                              children: produkList.map((produk) {
                                return ProductCard(
                                  imageProduct: produk.Gambar,
                                  date: produk.timestamp != null
                                      ? DateFormat(
                                          'dd-MM-yyyy',
                                        ).format(produk.timestamp!.toDate())
                                      : 'Tanggal Kosong',
                                  time: produk.timestamp != null
                                      ? DateFormat(
                                          'HH:mm',
                                        ).format(produk.timestamp!.toDate())
                                      : 'Jam Kosong',
                                  price:
                                      produk.KategoriJual.toLowerCase() == 'gratis'
                                      ? 'GRATIS'
                                      : 'Rp${produk.Harga}',
                                  location: produk.lokasiPenjual?? '',
                                  title: produk.Judul,
                                  deskripsi: produk.Deskripsi,
                                  kategori: produk.KategoriBuku,
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 12,
            bottom: 10,
            child:
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/quiz'),
              child: Image.asset(
                "assets/images/floatinglamp.png",
                width: 77,
                height: 77,
              ),
              )

          ),
        ],
      ),

      bottomNavigationBar: BottomNavbar(selectedItem: 0),
    );
  }
}
