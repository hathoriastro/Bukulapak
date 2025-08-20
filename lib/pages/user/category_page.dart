import 'package:bukulapak/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:bukulapak/components/user/category_card.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size; // Size of the screen
    var screenWidth = screenSize.width; // Screen width
    var screenHeight = screenSize.height; // Screen height

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Sign In"),
      // ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.05, // Responsive height for the top space
          ),
          SizedBox(
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  SizedBox(width: screenWidth * 0.05), // Add some left padding
                  Image.asset(
                    "assets/images/logo_bukulapak.png",
                    width: screenWidth * 0.1,
                  ),
                  SizedBox(
                    width: screenWidth * 0.02,
                  ), // Space between logo and text
                  Text(
                    'BUKULAPAK',
                    style: TextStyle(
                      fontFamily: 'poppins',
                      color: darkBlue,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.008,
            ),
            child: TextField(
              // controller: _emailController,
              decoration: InputDecoration(
                labelText: "Search",
                labelStyle: TextStyle(
                  fontFamily: 'poppins',
                  color: Colors.black54,
                  fontSize: screenWidth * 0.03,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: lightGray),
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: Icon(Icons.search, color: Colors.black),
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.02),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Text(
                "Kategori",
                style: TextStyle(
                  fontFamily: 'poppins',
                  color: darkBlue,
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: screenWidth * 0.05, // Space between cards
              runSpacing: screenHeight * 0.02, // Space between rows
              children: [
                CategoryCard(
                  title: 'Kimia',
                  imageUrl: 'assets/images/logo_bukulapak.png',
                  onTap: () {
                    // Handle tap
                  },
                ),
                CategoryCard(
                  title: 'Fisika',
                  imageUrl: 'assets/images/logo_bukulapak.png',
                  onTap: () {
                    // Handle tap
                  },
                ),
                CategoryCard(
                  title: 'Matematika',
                  imageUrl: 'assets/images/logo_bukulapak.png',
                  onTap: () {
                    // Handle tap
                  },
                ),
                CategoryCard(
                  title: 'UTBK',
                  imageUrl: 'assets/images/logo_bukulapak.png',
                  onTap: () {
                    // Handle tap
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
