import 'package:bukulapak/components/colors.dart';
import 'package:flutter/material.dart';

class KeranjangCard extends StatefulWidget {
  final String coverbook;
  final String text1;
  final String text2;
  final String price;

  const KeranjangCard({
    super.key,
    required this.coverbook,
    required this.text1,
    required this.text2,
    required this.price,
  });

  @override
  State<KeranjangCard> createState() => _KeranjangCardState();
}

class _KeranjangCardState extends State<KeranjangCard> {
  bool isClicked = false;

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
          onTap: () {
            setState(() {
              isClicked = !isClicked;
            });
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 15),
            width: sizewidth * 402 / fullwidth,
            height: sizeheight * 101 / fullheight,
            decoration: BoxDecoration(
              color: isClicked ? lightBlue : Colors.white,
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
              padding: const EdgeInsets.only(
                right: 37,
                top: 15,
                bottom: 15,
                left: 15,
              ),
              child: Row(
                children: [
                  // COVER PRODUCT
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isClicked ? Colors.white : Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.text2,
                              style: TextStyle(
                                color: isClicked ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              widget.price,
                              style: TextStyle(
                                color: isClicked ? Colors.white : Colors.black,
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
            padding: const EdgeInsets.only(
              top: 5,
              right: 15,
            ),
            child: Icon(
              Icons.remove_circle_outline,
              color : isClicked ? Colors.white : Colors.black
            )
          ),
        ),
      ],
    );
  }
}
