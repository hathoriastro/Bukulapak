import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/navbar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.1),
          Container(
            width: screenHeight * 0.5,
            height: screenWidth * 0.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: lightGray,
              image: DecorationImage(
                image: AssetImage("assets/images/dummy_pp.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text(
            "Nama User",
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: darkBlue,
            ),
          ),
          SizedBox(height: screenHeight * 0.001),
          Text(
            "emailuser@gmail.com",
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.bold,
              color: orange,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: lightBlue, width: 2), // custom border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Edit profil", style: TextStyle(color: lightBlue)),
              ),
              SizedBox(width: screenWidth * 0.02),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Icon(Icons.logout),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.04),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customBox(
                  context: context,
                  boxtitle: 'Pesanan',
                  boxicon: Icons.inbox,
                  boxcolor: orange,
                  textcolor: darkBlue,
                ),
                customBox(
                  context: context,
                  boxtitle: 'Favorit',
                  boxicon: Icons.favorite,
                  boxcolor: darkBlue,
                  textcolor: orange,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 1, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customBox(
                  context: context,
                  boxtitle: 'Toko Anda',
                  boxicon: Icons.store,
                  boxcolor: darkBlue,
                  textcolor: orange,
                ),
                customBox(
                  context: context,
                  boxtitle: 'Bahasa',
                  boxicon: Icons.language,
                  boxcolor: orange,
                  textcolor: darkBlue,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(selectedItem: 4),
    );
  }
}

Widget customBox({
  required BuildContext context,
  required String boxtitle,
  required IconData boxicon,
  required Color boxcolor,
  required Color textcolor,
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Container(
    height: screenHeight * 0.18,
    width: screenWidth * 0.4,
    decoration: BoxDecoration(
      color: boxcolor,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(boxicon, color: Colors.white, size: 50),
        SizedBox(height: 8),
        Text(
          boxtitle,
          style: TextStyle(fontWeight: FontWeight.bold, color: textcolor),
        ),
      ],
    ),
  );
}
