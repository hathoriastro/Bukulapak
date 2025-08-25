import 'package:bukulapak/components/colors.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
   bool isFavorite = false;

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
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: sizeheight * 0.03,
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
                          fontSize: sizeheight * 0.013,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: lightGray),
                      SizedBox(width: sizewidth * 0.01),
                      Text(
                        'Bekasi, Indonesia',
                        style: TextStyle(
                          fontSize: sizeheight * 0.012,
                          color: lightGray,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(top: 10, bottom: 15),
              child: Container(
                height: sizeheight * 0.25,
                width: sizewidth * 0.9,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage('assets/images/buku.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hujan - Tere Liye',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Stock : 19 Juta',
                style: TextStyle(fontSize: 13, color: lightGray),
              ),
            ),
            SizedBox(height: sizeheight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Novel, Fiction'),
              ],
            ),
            SizedBox(height: sizeheight * 0.02),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Product Overview',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Lorem Ipsum Dolor Sit Amet',
                style: TextStyle(
                  color: lightGray,
                  fontSize: 12
                ),
                ),
            )
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
