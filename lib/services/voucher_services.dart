import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VoucherServices {
  String generateVoucher(){
    final random = DateTime.now().millisecondsSinceEpoch;
    return "QUIZ30-${random.toString().substring(random.toString().length - 4)}";
  }

  Future<void> saveVoucher(String code) async {
    FirebaseFirestore.instance
        .collection('voucher')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'code' : code,
    });
  }

  Future<void> applyVoucher(String code) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('voucher')
        .doc(code)
        .get();

    if (snapshot.exists) {
      print("Voucher valid: ${snapshot.data()}");
    } else {
      print("Voucher tidak ditemukan");
    }
  }


}