import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/navbar.dart';
import 'package:bukulapak/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? _userProfil;
  bool _isLoading = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = _auth.currentUser;
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      DocumentSnapshot userDoc =
      await _firestore.collection('user').doc(user.uid).get();

      print('userDoc.exists=${userDoc.exists}, userDoc.data=${userDoc.data()}');

      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          _userProfil = UserModel.fromMap(userData);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading user profile: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          SizedBox(height: screenHeight * 0.1),

          /// Foto Profil
          CircleAvatar(
            radius: screenWidth * 0.15,
            backgroundColor: lightGray,
            backgroundImage: _userProfil?.imageURL != null &&
                _userProfil!.imageURL!.isNotEmpty
                ? NetworkImage(_userProfil!.imageURL!)
                : null,
            child: (_userProfil?.imageURL == null ||
                _userProfil!.imageURL!.isEmpty)
                ? Icon(Icons.person,
                size: screenWidth * 0.15, color: Colors.white)
                : null,
          ),

          SizedBox(height: screenHeight * 0.02),

          /// Nama
          Text(
            _userProfil?.name ?? "Tanpa Nama",
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.bold,
              color: darkBlue,
            ),
          ),

          SizedBox(height: screenHeight * 0.001),

          /// Email
          Text(
            _userProfil?.email ?? "Tidak ada email",
            style: TextStyle(
              fontFamily: 'poppins',
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.bold,
              color: orange,
            ),
          ),

          SizedBox(height: screenHeight * 0.01),

          /// Tombol Edit Profil & Logout
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit_profile');
                },
                style: OutlinedButton.styleFrom(
                  side:
                  BorderSide(color: lightBlue, width: 2), // custom border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Edit profil",
                    style: TextStyle(color: lightBlue)),
              ),
              SizedBox(width: screenWidth * 0.02),
              FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Icon(Icons.logout),
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.04),


          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
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

  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/homepage');
    },
    child: Container(
      height: screenHeight * 0.18,
      width: screenWidth * 0.4,
      decoration: BoxDecoration(
        color: boxcolor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(boxicon, color: Colors.white, size: 50),
          const SizedBox(height: 8),
          Text(
            boxtitle,
            style: TextStyle(fontWeight: FontWeight.bold, color: textcolor),
          ),
        ],
      ),
    ),
  );
}
