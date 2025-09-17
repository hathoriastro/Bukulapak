import 'package:bukulapak/components/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// Warna background custom input
const Color darkWhite = Color(0xFFF2F2F2);

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  String? _selectedLocation;

  DateTime? _birthDate;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      final doc = await _firestore.collection("user").doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        _nameController.text = data['name'] ?? '';
        _phoneController.text = data['phone'] ?? '';
        _addressController.text = data['address'] ?? '';
        _selectedLocation = data['location'];
        if (data['birthDate'] is Timestamp) {
          _birthDate = (data['birthDate'] as Timestamp).toDate();
        }
      }
    } catch (e) {
      debugPrint("Error load profile: $e");
    }

    if (mounted) setState(() => _isLoading = false);
  }

  Future<void> _saveProfile() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    final user = _auth.currentUser;
    if (user == null) return;

    try {
      await _firestore.collection("user").doc(user.uid).set({
        "name": _nameController.text,
        "phone": _phoneController.text,
        "address": _addressController.text,
        "location": _selectedLocation,
        "birthDate": _birthDate != null
            ? Timestamp.fromDate(_birthDate!)
            : null,
      }, SetOptions(merge: true));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profil berhasil diperbarui!")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint("Error save profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal memperbarui profil.")),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _pickBirthDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _birthDate = picked);
    }
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.pushNamed(context, '/lokasipage');
    if (result != null && result is String) {
      setState(() => _selectedLocation = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    final fullheight = 956;
    final fullwidth = 440;

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        leadingWidth: 30,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        elevation: 4,
        shadowColor: Colors.grey.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: true,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Edit",
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: orange,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  "Profil",
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
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            customInputField(
              context: context,
              title: "Nama Lengkap",
              labelText: "Masukkan nama lengkap",
              controller: _nameController,
            ),
            customInputField(
              context: context,
              title: "Nomor Telepon",
              labelText: "Masukkan nomor telepon",
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            customInputField(
              context: context,
              title: "Alamat",
              labelText: "Masukkan alamat lengkap",
              controller: _addressController,
            ),

            // Tanggal lahir
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Align(
              alignment: const Alignment(-0.83, 0),
              child: Text(
                "Tanggal Lahir",
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
              ),
            ),
            GestureDetector(
              onTap: _pickBirthDate,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: darkWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _birthDate != null
                          ? DateFormat("dd MMM yyyy").format(_birthDate!)
                          : "Pilih Tanggal Lahir",
                    ),
                    const Icon(Icons.calendar_today, size: 18),
                  ],
                ),
              ),
            ),

            // Lokasi
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Align(
              alignment: const Alignment(-0.83, 0),
              child: Text(
                "Lokasi",
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                ),
              ),
            ),
            GestureDetector(
              onTap: _pickLocation,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: darkWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedLocation ?? "Pilih Lokasi"),
                    const Icon(Icons.location_on, size: 18),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _isSaving ? null : _saveProfile();
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
              child: _isSaving
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      "Simpan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔧 Custom Input Field
Widget customInputField({
  required BuildContext context,
  required String title,
  required String labelText,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  List<TextInputFormatter>? inputFormatters,
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: screenHeight * 0.02),
      Align(
        alignment: const Alignment(-0.83, 0),
        child: Text(
          title,
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
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
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
