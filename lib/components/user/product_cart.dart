import 'package:badges/badges.dart' as badges;
import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/pages/user/keranjang_page.dart';
import 'package:bukulapak/services/tambahproduk_service.dart';
import 'package:flutter/material.dart';

import '../../model/keranjang_model.dart';

class ShoppingCart extends StatelessWidget {
  final TambahprodukService _tambah = TambahprodukService();

  ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<KeranjangModel>>(
      stream: _tambah.getKeranjang(),
      builder: (context, snapshot) {
        int itemCount = 0;
        if (snapshot.hasData) {
          itemCount = snapshot.data!.length;
        }

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KeranjangPage()),
            );
          },
          child: badges.Badge(
            position: badges.BadgePosition.topEnd(top: -12, end: -10),
            badgeStyle: badges.BadgeStyle(
              badgeColor: darkBlue,
            ),
            badgeContent: Text(
              itemCount.toString(), // <-- jumlah item keranjang
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            child: Image.asset('assets/images/cart.png', width: 28),
          ),
        );
      },
    );
  }
}
