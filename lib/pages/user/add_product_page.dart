import 'package:bukulapak/components/colors.dart';
import 'package:flutter/material.dart';
import 'package:bukulapak/components/user/option_button.dart';
import 'package:bukulapak/components/user/add_button.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _penerbitController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        leadingWidth: screenHeight,
        title: Column(
          children: [
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tambah",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: orange,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.02,
                ), // Space between logo and title
                Text(
                  "Produk",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
      ),

      body: 
      SingleChildScrollView(
        child:
        Column(
        children: [
          customInputField(
            context: context,
            title: 'Judul',
            labelText: 'Hujan',
            controller: _judulController,
          ),
          customInputField(
            context: context,
            title: 'Penerbit',
            labelText: 'PT Gramedia',
            controller: _penerbitController,
          ),
          customInputField(
            context: context,
            title: 'ISBN',
            labelText: '123-456-789',
            controller: _isbnController,
          ),

          // Option Button Gratis / Berbayar
          SizedBox(height: screenHeight * 0.02),
          Align(
            alignment: Alignment(-0.78, 0),
            child: Text(
              'Gratis / Berbayar', 
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: screenWidth * 0.03,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.008,
            ),
            child: OptionButton(
              option1: 'Gratis',
              option2: 'Berbayar',
            ),
          ),

          customInputField(
            context: context,
            title: 'Deskripsi',
            labelText: '',
            controller: _deskripsiController,
          ),

          // Tambah gambar
          SizedBox(height: screenHeight * 0.02),
          Align(
            alignment: Alignment(-0.78, 0),
            child: Text(
              'Tambah Gambar', 
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: screenWidth * 0.03,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.02),
          IconButtonComponent(icon: Icons.add, onPressed: () {

          }),

          // Tambah video
          SizedBox(height: screenHeight * 0.02),
          Align(
            alignment: Alignment(-0.78, 0),
            child: Text(
              'Tambah Video', 
              style: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: screenWidth * 0.03,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.02),
          IconButtonComponent(icon: Icons.add, onPressed: () {

          },),

          // Tombol Unggah Produk
          SizedBox(height: screenHeight * 0.02),
          ElevatedButton(
            onPressed: () {
              // Navigasi disini
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: orange,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.2,
                vertical: screenHeight * 0.02,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "Unggah Produk",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.02),
        ],
      ),
      )
      
    );
  }
}

Widget customInputField({
  required BuildContext context,
  required String title, // Dynamic title text
  required String labelText, // Dynamic label text for TextField
  required TextEditingController controller, // Dynamic controller
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: screenHeight * 0.02),
      Align(
        alignment: Alignment(-0.83, 0),
        child: Text(
          title, // Dynamic title
          style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: screenWidth * 0.03,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenHeight * 0.008,
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              fontFamily: 'poppins',
              color: Colors.black54,
              fontSize: screenWidth * 0.03,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: darkWhite,
            filled: true,
          ),
        ),
      ),
    ],
  );
}
