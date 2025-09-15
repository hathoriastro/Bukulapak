
import 'package:badges/badges.dart' as badges;
import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/pages/user/keranjang_page.dart';
import 'package:flutter/material.dart';



class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => KeranjangPage()),
);

      },child:  badges.Badge(
              position: badges.BadgePosition.topEnd(top: -12, end: -10),
              badgeStyle: badges.BadgeStyle(badgeColor: darkBlue),
              badgeContent: Text(
                '2',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              child: Image.asset('assets/images/cart.png', width: 28),
            ),
    );
  }
}