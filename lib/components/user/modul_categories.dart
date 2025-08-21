import 'package:bukulapak/components/colors.dart';
import 'package:flutter/material.dart';

class ModulCategories extends StatefulWidget {
  const ModulCategories({super.key});

  @override
  State<ModulCategories> createState() => _ModulCategories();
}

class _ModulCategories extends State<ModulCategories>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> text = ["SD", "SMP", "SMA"];
  final List<Color> activeColors = [sd, smp, sma];

  @override
  //DISPLAY LOGIC
  void initState() {
    super.initState();
    _tabController = TabController(length: text.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabs: List.generate(text.length, (index) {
          final bool isActive = _tabController.index == index;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 29,
                width: 102,
                decoration: BoxDecoration(
                  color: isActive ? activeColors[index] : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: isActive
                      ? null
                      : Border.all(color: lightGray, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    text[index],
                    style: TextStyle(
                      color: isActive ? Colors.white : lightGray,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
