import 'package:bukulapak/components/user/list_books.dart';
import 'package:bukulapak/components/user/product_cart.dart';
import 'package:bukulapak/pages/user/home.dart';
import 'package:flutter/material.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({super.key});

  @override
  State<ListProductPage> createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
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
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(
            left: 10,right: 17, top: 27
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context
                    );
                  },
                  child: Icon(Icons.arrow_back),
                ),
              Text('Daftar Produk', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: ShoppingCart()
                ),
            ],
          ),
        ),
      ),
      body: ListBooks(currentindex: 1,) ,
    );
  }
}