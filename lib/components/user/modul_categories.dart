import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/modul_card.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class ModulCategories extends StatefulWidget {
  const ModulCategories({super.key});

  @override
  State<ModulCategories> createState() => _ModulCategoriesState();
}

class _ModulCategoriesState extends State<ModulCategories>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> text = ["SD", "SMP", "SMA"];
  final List<Color> activeColors = [sd, smp, sma];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: text.length, vsync: this);
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
    return DefaultTabController(
      length: text.length,
      child: Column(
        children: [
          ButtonsTabBar(
            controller: _tabController,
            backgroundColor: activeColors[_tabController.index],
            contentCenter: true,
            width: 110,
            height: 40,
          
            unselectedBackgroundColor: Colors.white,
            unselectedLabelStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w700,
            ),
            labelStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            borderWidth: 10,
            borderColor: activeColors[_tabController.index],
            unselectedBorderColor: lightGray,
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
                        : lightGray,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                //SD
                GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  padding: const EdgeInsets.only(left: 31, right: 31, bottom: 31),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  children: const [
                    ModulCard(
                      title: "Pecahan",
                      image: "assets/images/modul_sample.png",
                    ),
                    ModulCard(
                      title: "Perkalian",
                      image: "assets/images/modul_sample.png",
                    ),
                    ModulCard(
                      title: "Pembagian",
                      image: "assets/images/modul_sample.png",
                    ),
                    ModulCard(
                      title: "Geometri",
                      image: "assets/images/modul_sample.png",
                    ),
                     ModulCard(
                        title: "Geometri",
                        image: "assets/images/modul_sample.png",
                      ),
                       ModulCard(
                        title: "Geometri",
                        image: "assets/images/modul_sample.png",
                      ),
                       ModulCard(
                        title: "Geometri",
                        image: "assets/images/modul_sample.png",
                      ),
                   
                  ],
                ),

                // SMP
                GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  padding: const EdgeInsets.only(left: 31, right: 31, bottom: 31),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  children: const [
                    ModulCard(
                      title: "Fisika Dasar",
                      image: "assets/images/modul_sample.png",
                    ),
                    ModulCard(
                      title: "Biologi",
                      image: "assets/images/modul_sample.png",
                    ),
                    ModulCard(
                      title: "Kimia",
                      image: "assets/images/modul_sample.png",
                    ),
                    ModulCard(
                      title: "Matematika Lanjut",
                      image: "assets/images/modul_sample.png",
                    ),
                  ],
                ),

                // SMA
                GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  padding: const EdgeInsets.only(left: 31, right: 31, bottom: 31),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  children: const [
                    ModulCard(
                      title: "Fisika Lanjutan",
                      image: "assets/images/modul_sample.png",
                    ),
                    ModulCard(
                      title: "Kalkulus",
                      image: "assets/images/modul_sample.png",
                    ),
                    ModulCard(
                      title: "Statistika",
                      image: "assets/images/modul_sample.png",
                    ),
                    ModulCard(
                      title: "Ekonomi",
                      image: "assets/images/modul_sample.png",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}