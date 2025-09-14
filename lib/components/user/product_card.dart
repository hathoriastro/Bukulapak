import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/pages/user/detail_page.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String imageProduct;
  final String date;
  final String time;
  final String price;
  final String location;
  final String title;
  final String kategori;
  final String deskripsi;

  const ProductCard({
    super.key,
    required this.imageProduct,
    required this.date,
    required this.time,
    required this.price,
    required this.location,
    required this.title,
    required this.kategori,
    required this.deskripsi,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final fullwidth = 440;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              imageProduct: widget.imageProduct,
              price: widget.price,
              location: widget.location,
              title: widget.title,
              kategori: widget.kategori,
              deskripsi: widget.deskripsi,
            ),
          ),
        );
      },
      child: Container(
        width: sizewidth * 182 / fullwidth,
        height: 234,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: lightGray, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                //IMAGE PRODUCT
                child: Image.network(
                  widget.imageProduct,
                  fit: BoxFit.cover,
                  width: sizewidth * 170 / fullwidth,
                  height: 134,
                ),
              ),
              SizedBox(height: 6),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      widget.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Expanded(
                          child: Text(
                            'Dijual ${widget.date}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 8, color: lightGray),
                          ),
                        ),
                        Text(
                          '${widget.time} WIB',
                          style: TextStyle(fontSize: 8, color: lightGray),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      widget.price,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.black,
                          size: 11,
                        ),
                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          widget.location,
                          style: TextStyle(fontSize: 8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
