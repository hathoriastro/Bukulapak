
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
      Navigator.pushReplacementNamed(context, '');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '');
    } else if (index == 4) {
      Navigator.pushReplacementNamed(context, '');
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
          icon: Image.asset('assets/images/Home.png', width: 29, height: 29,),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/modul.png', width: 29, height: 29,),
          label: 'Modul',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/unggah.png', width: 44, height: 44,),
          label: 'Unggah',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/barter.png',  width: 29, height: 29,),
          label: 'Barter',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/profil.png',),
          label: 'Profil',
        ),
      ],
      selectedItemColor: darkBlue,
      currentIndex: widget.selectedItem,
      onTap: changeSelectedNavBar,
    )
    );
  }
}
