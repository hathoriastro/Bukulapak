import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/modul_card.dart';
import 'package:bukulapak/components/user/product_card.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class ListBooks extends StatefulWidget {
  final int currentindex;
  const ListBooks ({super.key, required this.currentindex});

  @override
  State<ListBooks > createState() => _ListBooksState();
}

class _ListBooksState extends State<ListBooks>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> text = ["Berbayar", "Gratis"];
  

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: text.length, vsync: this, initialIndex: widget.currentindex);
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
    return DefaultTabController(
      length: text.length,
      
      child: Padding(
        padding: const EdgeInsets.only(
          top: 25
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonsTabBar(
              controller: _tabController,
              backgroundColor: lightBlue,
              contentCenter: true,
              width: sizewidth* 182/ fullwidth,
              height: 41,
            
              unselectedBackgroundColor: Colors.white,
              unselectedLabelStyle: TextStyle(
                color: lightBlue,
                fontWeight: FontWeight.w800,
                fontSize: 24
              ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24
              ),
              borderWidth: 10,
              unselectedBorderColor: lightBlue,
              radius: 10,
              tabs: List.generate(
                text.length,
                (index) => Tab(
                  child: Text(
                    text[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
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

                  //Berbayar
                  GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: (sizewidth * 186 / fullwidth) / 215,
                    padding: EdgeInsets.only(left: 24, right: 8, bottom: 15),
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 15,
                    children: const [
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
        
                  // GRATIS
                GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: sizewidth * 182 / fullwidth / 215,
                    padding: EdgeInsets.only(left: 24, right: 8, bottom: 15),
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 15,
                    children: const [
                      ProductCard(
                                imageProduct: 'assets/images/banner1.jpg',
                                date: '22-08-2025',
                                time: '00.00',
                                price: 'Gratis',
                                location: 'Kota Malang, Ja...',
                                title: 'Hujan',
                              ),
                              ProductCard(
                                imageProduct: 'assets/images/banner1.jpg',
                                date: '22-08-2025',
                                time: '00.00',
                                price: 'Gratis',
                                location: 'Kota Malang, Ja...',
                                title: 'Hujan',
                              ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}