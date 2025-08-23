import 'package:bukulapak/components/user/banner_carousel.dart';
import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/product_card.dart';
import 'package:bukulapak/components/user/navbar.dart';
import 'package:bukulapak/components/user/product_cart.dart';
import 'package:bukulapak/pages/user/category_page.dart';
import 'package:bukulapak/pages/user/list_product_page.dart';
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
              suffixIcon: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryPage()),
                  );
                },
                child: const Icon(Icons.search),
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListProductPage(currentIndx: 1,),
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

                      SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ProductCard(
                              imageProduct: 'assets/images/banner1.jpg',
                              date: '22-08-2025',
                              time: '00.00',
                              price: '24000',
                              location: 'Kota Malang, Ja...',
                              title: 'Hujan',
                            ),

                            ProductCard(
                              imageProduct: 'assets/images/banner1.jpg',
                              date: '22-08-2025',
                              time: '00.00',
                              price: '24000',
                              location: 'Kota Malang, Ja...',
                              title: 'Hujan',
                            ),

                            ProductCard(
                              imageProduct: 'assets/images/banner1.jpg',
                              date: '22-08-2025',
                              time: '00.00',
                              price: '24000',
                              location: 'Kota Malang, Ja...',
                              title: 'Hujan',
                            ),
                          ],
                        ),
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
                            ProductCard(
                              imageProduct: 'assets/images/banner1.jpg',
                              date: '22-08-2025',
                              time: '00.00',
                              price: '24000',
                              location: 'Kota Malang, Ja...',
                              title: 'Hujan',
                            ),
                            ProductCard(
                              imageProduct: 'assets/images/banner1.jpg',
                              date: '22-08-2025',
                              time: '00.00',
                              price: '24000',
                              location: 'Kota Malang, Ja...',
                              title: 'Hujan',
                            ),
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
