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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      color: cyan,
      child: SizedBox(
        width: sizewidth *175/fullwidth,
        height: 170,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                width: 115,
                height: 115,
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
