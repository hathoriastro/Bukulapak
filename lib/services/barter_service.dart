import 'package:bukulapak/model/bukuBarter_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class BarterService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  Future<void> addBarter(bukuBarter barter) async {
    try{
      final docRef = _firestore.collection('userLocation').doc(_firebaseAuth.currentUser?.uid);
      final pos = await Geolocator.getCurrentPosition();
      final data = {
        'id': _firebaseAuth.currentUser?.uid,
        'Judul': barter.Judul,
        'Penerbit': barter.Penerbit,
        'ISBN': barter.ISBN,
        'Kategori': barter.Kategori,
        'Gambar': barter.Gambar,
        'updated': FieldValue.serverTimestamp(),
        'latitude' : pos.latitude,
        'longitude' : pos.longitude,
      };

      final docSnapshot = await docRef.get();
      if(docSnapshot.exists){
        await docRef.update(data);
      } else {
        await docRef.set(data, SetOptions(merge: true));
      }
    } catch(e) {
      
    }
  }
}