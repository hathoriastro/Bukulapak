import 'package:bukulapak/components/banner_carousel.dart';
import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/card_product.dart';
import 'package:bukulapak/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: sizeheight * 112 / fullheight,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        title: SizedBox(
          height: 42,
          width: sizewidth * 259 / fullwidth,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),

        actions: [
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: -12, end: -10),
            badgeStyle: badges.BadgeStyle(badgeColor: darkBlue),
            badgeContent: Text(
              '2',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            child: Image.asset('assets/images/cart.png', width: 28),
          ),
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
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.03,
              horizontal: MediaQuery.of(context).size.width * 0.035,
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
                  padding: EdgeInsets.all(13),
                  child: Column(
                    children: [
                      Row(
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

                      SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [ProductCard(), ProductCard()]),
                      ),
                      SizedBox(height: 40),
                      Row(
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
                      SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                          ],
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
            bottom: 10, // biar ga ketutup navbar
            child: Image.asset(
                "assets/images/floatinglamp.png",
                width: 77,
                height: 77,
              ),
            
          ),
        ],
      ),

      bottomNavigationBar: BottomNavbar(selectedItem: 0),
    );
  }
}
