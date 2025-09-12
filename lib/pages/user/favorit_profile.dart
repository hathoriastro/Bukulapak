import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/product_card.dart';
import 'package:flutter/material.dart';

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
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
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
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (sizewidth * 186 / fullwidth) / 215,
        padding: EdgeInsets.only(left: 24, right: 8, bottom: 15, top: 20),
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
        ],
      ),
    );
  }
}
