import 'package:bukulapak/components/colors.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  final int selectedItem;
  const BottomNavbar({super.key, required this.selectedItem});

  @override
  State<BottomNavbar> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNavbar> {
  int _currentIndex = 0;

  void changeSelectedNavBar(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/homepage');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/modulGo');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/add_product');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/barterin');
    } else if (index == 4) {
      Navigator.pushReplacementNamed(context, '/profilepage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
  decoration: const BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: softgray,
        spreadRadius: 0,
        blurRadius: 10,
        offset: Offset(0, -2), 
      ), 
    ],
  ),
  child: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled, size: 26,),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded, size: 26,),
          label: 'Modul',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outlined, size: 44,),
          label: 'Unggah',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.handshake_rounded, size: 26),
          label: 'Barter',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 26),
          label: 'Profil',
        ),
      ],
      selectedItemColor: darkBlue,
      unselectedItemColor: softgray,
      currentIndex: widget.selectedItem,
      onTap: changeSelectedNavBar,
    )
    );
  }
}
