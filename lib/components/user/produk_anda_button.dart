import 'package:bukulapak/components/colors.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class ProdukAndaButton extends StatefulWidget {
  final int currentindex;
  const ProdukAndaButton({super.key, required this.currentindex});

  @override
  State<ProdukAndaButton> createState() => _ProdukAndaButtonState();
}

class _ProdukAndaButtonState extends State<ProdukAndaButton>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> text = ["Dikemas", "Diantar", "Selesai"];

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

    return DefaultTabController(
      length: text.length,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonsTabBar(
              controller: _tabController,
              backgroundColor: lightBlue,
              contentCenter: true,
              width: sizewidth * 125 / fullwidth,
              height: 41,
              unselectedBackgroundColor: Colors.transparent,
              unselectedLabelStyle: TextStyle(
                color: lightBlue,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
              labelStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
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
                      fontSize: 17,
                      color: _tabController.index == index
                          ? Colors.white
                          : lightBlue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
