import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/checkout_page.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String imageProduct;
  final String price;
  final String location;
  final String title;
  final String kategori;
  final String deskripsi;

  const DetailPage({
    super.key,
    required this.imageProduct,
    required this.price,
    required this.location,
    required this.title,
    required this.kategori,
    required this.deskripsi
  });

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
                        widget.location,
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
                    image: NetworkImage(widget.imageProduct),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
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
                'Stok : 19 Juta',
                style: TextStyle(fontSize: 13, color: lightGray),
              ),
            ),
            SizedBox(height: sizeheight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Kategori', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(widget.kategori),
              ],
            ),
            SizedBox(height: sizeheight * 0.02),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Deskripsi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.deskripsi,
                style: TextStyle(color: lightGray, fontSize: 12),
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
              Row(
                children: [
                  Text(widget.title),
                  Text(' - '),
                  Text(widget.price),
                ],
              ),
              FilledButton(
                onPressed: () {
                  Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CheckoutPage()
          ),
        );
                },
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

// String _limitWords(String text, int maxWords) {
//   final words = text.split(' ');
//   if (words.length <= maxWords) {
//     return text;
//   } else {
//     return words.take(maxWords).join(' ') + '...';
//   }
// }