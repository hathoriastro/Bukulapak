import 'package:bukulapak/components/colors.dart';
import 'package:bukulapak/components/user/navbar.dart';
import 'package:bukulapak/model/tambahproduk_model.dart';
import 'package:bukulapak/services/image_service.dart';
import 'package:bukulapak/services/tambahproduk_service.dart';
import 'package:bukulapak/services/video_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bukulapak/components/user/option_button.dart';
import 'package:bukulapak/components/user/add_button.dart';
import 'package:flutter/services.dart';

import 'package:video_thumbnail/video_thumbnail.dart';
import 'dart:typed_data';

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
  final TextEditingController _hargaController = TextEditingController();
  String? _selectedKategoriJual; // Gratis / Berbayar
String? _selectedKategoriBuku; // Novel / UTBK / Komik / SD

  final ImageService _imageService = ImageService();
  final VideoPicker _videoPicker = VideoPicker();
  TambahprodukService _addProduct = TambahprodukService();

  Uint8List? _thumbnail;

  Future<void> generateThumbnail(String videoUrl) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.PNG,
      maxWidth: 128,
      quality: 75,
    );

    setState(() {
      _thumbnail = uint8list;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    final fullheight = 956;
    final fullwidth = 440;
    final ImageService imageService = ImageService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        leadingWidth: screenHeight,
        backgroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
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

      body: SingleChildScrollView(
        child: Column(
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
                onChanged: (value) {
                  setState(() {
                    _selectedKategoriJual = value;
                  });
                },
              ),
            ),

            if (_selectedKategoriJual == 'Berbayar')
            
              customInputField(
                context: context,
                title: 'Harga',
                labelText: '100.000',
                controller: _hargaController,
                keyboardType: TextInputType.number,
  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),

            customInputField(
              context: context,
              title: 'Deskripsi',
              labelText: '',
              controller: _deskripsiController,
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
                onChanged: (value) {
                  setState(() {
                    _selectedKategoriBuku = value;
                  });
                },
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

            _imageService.imageUrl == null
                ? IconButtonComponent(
                    icon: Icons.add,
                    onPressed: () async {
                      await _imageService.pickImage();
                      setState(() {});
                    },
                  )
                : Container(
                    width: screenWidth * 410 / fullwidth,
                    height: screenHeight * 212 / fullheight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        _imageService.imageUrl??"",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

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
            _thumbnail == null
                ? IconButtonComponent(
                    icon: Icons.add,
                    onPressed: () async {
                      await _videoPicker.pickVideo();
                      if (_videoPicker.videoUrl != null) {
                        await generateThumbnail(_videoPicker.videoUrl!);
                        
                      }
                    },
                  )
                : Container(
                    width: screenWidth * 410 / fullwidth,
                    height: screenHeight * 212 / fullheight,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(_thumbnail!, fit: BoxFit.cover),
                    ),
                  ),



            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () async {
                final User? user = FirebaseAuth.instance.currentUser;
                final String uid = user?.uid ?? '';

                TambahprodukModel tambahproduk = TambahprodukModel(
                 Judul: _judulController.text,
                  Penerbit: _penerbitController.text,
                  ISBN: _isbnController.text,
                  KategoriBuku: _selectedKategoriBuku?? '',
                  KategoriJual: _selectedKategoriJual ?? '',
                  Gambar: _imageService.imageUrl ?? '',
                  Video: _videoPicker.videoUrl ?? '',
                  Harga: _hargaController.text,
                  Deskripsi: _deskripsiController.text,
                  timestamp: Timestamp.fromDate(DateTime.now()),
                  ownerId: uid,
                );

                await _addProduct.addProduct(
                  tambahproduk
                );

                await _addProduct.addProductAll(
                  tambahproduk
                );

                Navigator.pushNamed(context, '/homepage');
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
      ),
      bottomNavigationBar: BottomNavbar(selectedItem: 2),
    );
  }
}

Widget customInputField({
  required BuildContext context,
  required String title, // Dynamic title text
  required String labelText, // Dynamic label text for TextField
  required TextEditingController controller, // Dynamic controller
  TextInputType keyboardType = TextInputType.text, // default text
  List<TextInputFormatter>? inputFormatters,  
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
          keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        ),
      ),
    ],
  );
}
