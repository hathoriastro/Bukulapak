import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/keranjang_card.dart';
import 'package:flutter/material.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullheight = 956;
    final fullwidth = 440;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: sizeheight * 112 / fullheight,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 40),
          child: Text(
            'Keranjang',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 120),
        child: Column(
          children: [
            KeranjangCard(
              coverbook: 'assets/images/logo_bukulapak.png',
              text1: 'Senja',
              text2: 'Helo - Tere Liye',
              price: 'Rp54.000',
            ),
            KeranjangCard(
              coverbook: 'assets/images/logo_bukulapak.png',
              text1: 'Senja',
              text2: 'Helo - Tere Liye',
              price: 'Rp54.000',
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20), 
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //KUPON
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: sizeheight * 81 / fullheight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: lightGray.withOpacity(0.25),
                    spreadRadius: 1.5,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Image.asset('assets/images/price-tag.png'),
                    const SizedBox(width: 10),
                    Text(
                      'Put Your Coupon',
                      style: TextStyle(color: softgray),
                    ),
                    const Spacer(),
                    Container(
                      width: sizewidth * 88 / fullwidth,
                      height: sizeheight * 46 / fullheight,
                      decoration: BoxDecoration(
                        color: customorange,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: lightGray.withOpacity(0.5),
                            spreadRadius: 1.5,
                            blurRadius: 4,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Apply',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),

            //CHECKOUT
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: sizeheight * 81 / fullheight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: lightGray.withOpacity(0.25),
                    spreadRadius: 1.5,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Total: Rp120.000,00',
                      style: TextStyle(
                        color: lightGray,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: sizewidth * 120 / fullwidth,
                      height: sizeheight * 46 / fullheight,
                      decoration: BoxDecoration(
                        color: customorange,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: lightGray.withOpacity(0.5),
                            spreadRadius: 1.5,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
