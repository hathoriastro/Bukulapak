import 'package:bukulapak/components/colors.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  CategoryCard({
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size; // Size of the screen
    var screenWidth = screenSize.width; // Screen width
    var screenHeight = screenSize.height; // Screen height

    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.asset(
              imageUrl,
              width: screenWidth * 0.37, // Responsive width
              height: screenHeight * 0.15, // Responsive height
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'poppins',
                  color: darkBlue,
                  fontSize: screenWidth * 0.04, // Responsive font size
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}