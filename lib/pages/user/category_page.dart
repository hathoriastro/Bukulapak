import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/pages/user/list_product_page.dart';
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
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: const Text("Sign In"),
      // ),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                Image.asset(
                  "assets/images/logo_bukulapak.png",
                  width: screenWidth * 0.1,
                ),
                SizedBox(
                  width: screenWidth * 0.15,
                ), // Space between logo and text
              ],
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
                suffixIcon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListProductPage(currentIndx: 0),
                      ),
                    );
                  },
                  child: const Icon(Icons.search),
                ),
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
