import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/pesanan_card.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullheight = 956;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: sizeheight * 112 / fullheight,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.001),
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 27),
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
                    'Checkout',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Container(color: Colors.transparent, width: sizewidth * 0.1),
                ],
              ),
            ),
            SizedBox(height: sizeheight * 0.006),
            Divider(),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
        child: Column(
          children: [
            PesananCard(
              coverbook: 'assets/images/logo_bukulapak.png',
              text1: 'Buku 4',
              text2: 'Penulis D',
              price: 'Rp80.000',
            ),
            PesananCard(
              coverbook: 'assets/images/logo_bukulapak.png',
              text1: 'Buku 4',
              text2: 'Penulis D',
              price: 'Rp80.000',
            ),

            SizedBox(height: sizeheight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Address',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: sizeheight * 0.01),
            Container(
              height: sizeheight * 0.2,
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(30),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: lightGray.withOpacity(0.7),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: lightGray),
                        Text(
                          "Nama" + " || " + "No Telp",
                          style: TextStyle(color: lightGray),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lorem Ipsum Dolor",
                          style: TextStyle(color: lightGray),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: sizeheight * 0.02),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Payment Method",
                  style: TextStyle(fontWeight: FontWeight.w600),
                  
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 20),
        child: Container(
          height: sizeheight * 0.07,
          decoration: BoxDecoration(
            color: Color(0xFFD6D6E8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Hujan - 65.000'),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(backgroundColor: lightBlue),
                child: Text(
                  'Add to Cart',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
