import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/modul_card.dart';
import 'package:bukulapak/components/user/modul_categories.dart';
import 'package:bukulapak/components/user/navbar.dart';
import 'package:flutter/material.dart';

class ModulPage extends StatelessWidget {
  const ModulPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullheight = 956;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: sizeheight * 112 / fullheight,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Modul',
              style: TextStyle(
                color: darkBlue,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Go',
              style: TextStyle(
                color: customorange,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        
      ),
      body: Column(
        children: [
          ModulCategories(),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1,
              padding: EdgeInsets.all(31),
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              children: const [
                ModulCard(title: "Pecahan", image: "assets/images/modul_sample.png"),
                ModulCard(
                  title: "Perkalian",
                  image: "assets/images/modul_sample.png",
                ),
                ModulCard(
                  title: "Pembagian",
                  image: "assets/images/modul_sample.png",
                ),
                ModulCard(title: "Geometri", image: "assets/images/modul_sample.png"),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(selectedItem: 1)
    );
  }
}
