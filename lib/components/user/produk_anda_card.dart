import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/produk_anda_button.dart';
import 'package:flutter/material.dart';

class ProdukAndaCardVertical extends StatefulWidget {
  final String coverbook;
  final String text1;
  final String text2;
  final String price;
  const ProdukAndaCardVertical({
    super.key,
    required this.coverbook,
    required this.text1,
    required this.text2,
    required this.price,
  });

  @override
  State<ProdukAndaCardVertical> createState() => _ProdukAndaCardVerticalState();
}

class _ProdukAndaCardVerticalState extends State<ProdukAndaCardVertical> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullheight = 956;
    final fullwidth = 440;

    return Column(
      children: [
        Container(
          width: sizewidth * 402 / fullwidth,
          height: sizeheight * 150 / fullheight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: lightGray.withOpacity(0.7),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 37, left: 15, top: 15),
                child: Row(
                  children: [
                    // COVER PRODUCT
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.coverbook,
                        fit: BoxFit.cover,
                        width: sizewidth * 49 / fullwidth,
                        height: sizeheight * 65 / fullheight,
                      ),
                    ),
                    const SizedBox(width: 17),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.text1,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text(widget.text2), Text(widget.price)],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ProdukAndaButton(currentindex: 0),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
