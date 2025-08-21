import 'package:bukulapak/components/colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sizewidth = size.width;
    
    final fullwidth = 440;
    return Container(
      width: sizewidth * 182 / fullwidth,
      height: 234,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1.5),

      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10),
              //IMAGE PRODUCT
              child: Image.asset(
                'assets/images/banner1.jpg',
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
                    'Hujan',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dijual 10-08-2025',
                        style: TextStyle(fontSize: 8, color: lightGray),
                      ),
                      Text(
                        '19.00 WIB',
                        style: TextStyle(fontSize: 8, color: lightGray),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Rp21.000',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
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
                      Text('Kota Malang...', style: TextStyle(fontSize: 8)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
