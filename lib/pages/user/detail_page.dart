import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/model/favoriteProduct_model.dart';
import 'package:bukulapak/model/keranjang_model.dart';
import 'package:bukulapak/pages/user/checkout_page.dart';
import 'package:bukulapak/pages/user/keranjang_page.dart';
import 'package:bukulapak/services/tambahproduk_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String imageProduct;
  final String price;
  final String location;
  final String title;
  final String kategori;
  final String deskripsi;
  final String time;
  final String date;

  const DetailPage({
    super.key,
    required this.imageProduct,
    required this.price,
    required this.location,
    required this.title,
    required this.kategori,
    required this.deskripsi,
    required this.time,
    required this.date,
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
    TambahprodukService _tambah = TambahprodukService();

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
      body: SingleChildScrollView(
        child: Padding(
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () async {
                      _tambah.addFavoriteProduct(
                        FavoriteproductModel(
                          Judul: widget.title,
                          Gambar: widget.imageProduct,
                          Harga: widget.price,
                          location: widget.location,
                          kategori: widget.kategori,
                          deskripsi: widget.deskripsi,
                          jam: widget.time,
                          tanggal: widget.date,
                        ),
                      );
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFavorite
                                ? 'Produk ditambahkan ke favorit'
                                : 'Produk dihapus dari favorit',
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: orange,
                        ),
                      );
                    },
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Harga',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.price,
                  style: TextStyle(fontSize: 14, color: lightGray),
                ),
              ),
              SizedBox(height: sizeheight * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kategori',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.kategori,
                  style: TextStyle(fontSize: 14, color: lightGray),
                ),
              ),
              SizedBox(height: sizeheight * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Deskripsi',
                  style: TextStyle(fontWeight: FontWeight.w600),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
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
              FilledButton(
  onPressed: () async {
    final alreadyInCart = await _tambah.checkKeranjang(widget.title);

    if (alreadyInCart) {
      // Produk sudah ada
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Produk sudah ada di keranjang"),
          backgroundColor: Colors.orange,
        ),
      );
    } else {
      // Tambah baru
      await _tambah.addKeranjang(
        KeranjangModel(
          judul: widget.title,
          gambar: widget.imageProduct,
          harga: widget.price,
          kategori: widget.kategori,
          id: '',
          isCheckout: false
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Produk berhasil ditambahkan ke keranjang"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KeranjangPage()),
      );
    }
  },
  style: FilledButton.styleFrom(
    backgroundColor: Colors.white,
    side: BorderSide(color: lightBlue, width: 2),
  ),
  child: Text(
    '+ Keranjang',
    style: TextStyle(
      fontWeight: FontWeight.w800,
      color: lightBlue,
    ),
  ),
              ),

              FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutPage(
                        coverbook: widget.imageProduct,
                        text1: widget.title,
                        text2: widget.kategori,
                        price: widget.price,
                        
                      ),
                    ),
                  );
                },
                style: FilledButton.styleFrom(backgroundColor: lightBlue),
                child: Text(
                  'Beli Sekarang',
                  style: TextStyle(fontWeight: FontWeight.w800),
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
