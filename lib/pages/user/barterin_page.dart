import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/navbar.dart';
import 'package:flutter/material.dart';
import 'package:bukulapak/components/user/option_button.dart';
import 'package:bukulapak/components/user/add_button.dart';

class BarterinPage extends StatefulWidget {
  const BarterinPage({super.key});

  @override
  _BarterinPageState createState() => _BarterinPageState();
}

class _BarterinPageState extends State<BarterinPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _penerbitController = TextEditingController();
  final TextEditingController _isbnController = TextEditingController();

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
                  "Barter",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: orange,
                  ),
                ),
                Text(
                  "In",
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

      body: Column(
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

          SizedBox(height: screenHeight * 0.02),
          Align(
            alignment: Alignment(-0.78, 0),
            child: Text(
              'Pilih Kategori', 
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
              option1: 'Novel',
              option2: 'UTBK',
              option3: 'Komik',
              option4: 'SD',
            ),
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

          SizedBox(height: screenHeight * 0.04),
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
              "Mulai Barter",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(selectedItem: 3),
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
          controller: controller, // Dynamic controller
          decoration: InputDecoration(
            labelText: labelText, // Dynamic label text
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
            fillColor: darkWhite, // You can replace this with your custom color
            filled: true,
          ),
        ),
      ),
    ],
  );
}