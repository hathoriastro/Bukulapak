import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/model/keranjang_model.dart';
import 'package:bukulapak/services/tambahproduk_service.dart';
import 'package:flutter/material.dart';

class KeranjangCard extends StatelessWidget {
  final KeranjangModel keranjangItem;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const KeranjangCard({
    Key? key,
    required this.keranjangItem,
    required this.isSelected,
    required this.onTap,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final sizeheight = size.height;
    final fullheight = 956;
    final fullwidth = 440;

    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(bottom: 15),
            width: sizewidth * 402 / fullwidth,
            height: sizeheight * 101 / fullheight,
            decoration: BoxDecoration(
              color: isSelected ? lightBlue : Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: lightGray.withOpacity(0.7),
                  spreadRadius: 1.5,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: [
                  // COVER PRODUCT
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      keranjangItem.gambar,
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
                          keranjangItem.judul,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              keranjangItem.kategori,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
  keranjangItem.isCheckout ? 'HABIS' : '${keranjangItem.harga}',
  style: TextStyle(
    color: keranjangItem.isCheckout
        ? Colors.red // warna kalau habis
        : (isSelected ? Colors.white : Colors.black), // warna normal tergantung selected
   
  ),
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
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(top: 5, right: 15),
            child: GestureDetector(
              onTap: onRemove,
              child: Icon(
                Icons.remove_circle_outline,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        )
      ],
    );
  }
}

