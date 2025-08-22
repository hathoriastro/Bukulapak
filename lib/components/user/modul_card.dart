import 'package:bukulapak/components/colors.dart';
import 'package:flutter/material.dart';

class ModulCard extends StatelessWidget {
  final String title;
  final String image;

  const ModulCard({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    final fullwidth = 440;
    final sizeheight = size.height;
    final fullheight = 956;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      color: cyan,
      child: SizedBox(
        width: sizewidth *175/fullwidth,
        height: sizeheight* 170/ fullheight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                width: sizewidth*115/fullwidth,
                height: sizeheight* 115/fullheight,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
