import 'package:bukulapak/components/colors.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

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
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/logo_bukulapak.png",
                width: screenWidth * 0.2,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Buat Akun Baru",
              style: TextStyle(
                fontFamily: 'poppins',
                color: darkBlue,
                fontSize: screenWidth * 0.03, // Responsive font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Email Input Field
          SizedBox(height: screenHeight * 0.05),
          Align(
            alignment: Alignment(-0.73, 0),
            child: Text(
              "Alamat Email",
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
              horizontal: screenWidth * 0.1,
              vertical: screenHeight * 0.008,
            ),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Masukkan Alamat Email Anda",
                labelStyle: TextStyle(
                  fontFamily: 'poppins',
                  color: Colors.black54,
                  fontSize: screenWidth * 0.03,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Password Field
          SizedBox(height: screenHeight * 0.02),
          Align(
            alignment: Alignment(-0.73, 0),
            child: Text(
              "Kata Sandi",
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
              horizontal: screenWidth * 0.1,
              vertical: screenHeight * 0.008,
            ),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Masukkan Kata Sandi Anda",
                labelStyle: TextStyle(
                  fontFamily: 'poppins',
                  color: Colors.black54,
                  fontSize: screenWidth * 0.03,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.02),
          Align(
            alignment: Alignment(-0.67, 0),
            child: Text(
              "Konfirmasi Kata Sandi",
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
              horizontal: screenWidth * 0.1,
              vertical: screenHeight * 0.008,
            ),
            child: TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: "Konfirmasi Kata Sandi Anda",
                labelStyle: TextStyle(
                  fontFamily: 'poppins',
                  color: Colors.black54,
                  fontSize: screenWidth * 0.03,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          
          SizedBox(height: screenHeight * 0.1),
          ElevatedButton(
            onPressed: () {
              // Navigasi disini
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: lightBlue,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.2,
                vertical: screenHeight * 0.02,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "Masuk",
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
            child: Text(
              'Cara lain untuk masuk',
              style: TextStyle(color: lightGray, fontSize: screenWidth * 0.025),
            ),
          ),
          Container(
            height: screenHeight * 0.05,
            width: screenWidth * 0.4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: lightGray, width: 1),
            ),
            child: Center(
              child: Image(
                image: AssetImage("assets/images/logo_google.png"),
                width: screenWidth * 0.07,
                height: screenHeight * 0.07,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sudah punya akun?",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    color: Colors.black54,
                    fontSize: screenWidth * 0.03,
                  ),
                ),
                SizedBox(width: screenWidth * 0.01),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/sign_in');
                  },
                  child: Text(
                    "Masuk",
                    style: TextStyle(
                      fontFamily: 'poppins',
                      color: lightBlue,
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
