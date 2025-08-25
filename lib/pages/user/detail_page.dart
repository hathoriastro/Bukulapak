import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/navbar.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullheight = 956;
    final fullwidth = 440;

    return Scaffold(
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
                    'Detail',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Container(color: Colors.transparent),
                ],
              ),
            ),
            SizedBox(height: sizeheight * 0.006),
            Divider(),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: sizeheight * 0.05,
                      height: sizewidth * 0.075,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: lightGray,
                        image: DecorationImage(
                          image: AssetImage("assets/images/dummy_pp.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: sizewidth * 0.01),
                    Text(
                      'Gibran Store',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: sizeheight * 0.013
                        ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: lightGray,
                      ),
                    SizedBox(width: sizewidth * 0.01),
                    Text(
                      'Bekasi, Indonesia',
                      style: TextStyle(
                        fontSize: sizeheight * 0.012,
                        color: lightGray
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            child: Image.asset('assets/images/logo_bukulapak.png')
          )
        ],
      ),
    );
  }
}
