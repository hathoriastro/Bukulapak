import 'dart:ui';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapServices {
  Future<void> updateUserLocation() async {
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    
    String uid = FirebaseAuth.instance.currentUser!.uid;
    
    await FirebaseFirestore.instance.collection('userLocation').doc(uid).set({
      'uid' : uid,
      'latitude' : pos.latitude,
      'longitude' : pos.longitude,
      'updated' : FieldValue.serverTimestamp()
    }, SetOptions(merge: true)
    );
  }

  Stream<List<Map<String, dynamic>>> getNearbyUsers(){
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('userLocation').snapshots().map((snap){
      return snap.docs
          .where((doc) => doc.id != uid)
          .map((doc) => doc.data())
          .toList();
    }
    );
  }

  Future<BitmapDescriptor> createCustomMarker(String imagerUrl) async {
    final ByteData imageData = await NetworkAssetBundle(Uri.parse(imagerUrl)).load("");
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(imageBytes, targetWidth: 100);
    final frame = await codec.getNextFrame();
    final byteData = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(imageBytes);

  }
}