import 'dart:ffi';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapServices {
  Future<void> updateUserLocation() async {
    LocationPermission permission = await GeolocatorPlatform.instance.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await GeolocatorPlatform.instance.requestPermission();
    }
    if(permission == LocationPermission.denied){
      return;
    }
    if(permission == LocationPermission.deniedForever){
      return;
    }
      Position pos = await GeolocatorPlatform.instance.getCurrentPosition(
      );

      String uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection('userLocation').doc(uid).set({
        'uid': uid,
        'latitude': pos.latitude,
        'longitude': pos.longitude,
        'updated': FieldValue.serverTimestamp()
      }, SetOptions(merge: true)
      );
    }

  Stream<List<Map<String, dynamic>>> getNearbyUsersWithLocation() {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('userLocation')
        .snapshots()
        .map((snap) {
      return snap.docs
          .where((doc) => doc.id != uid)
          .map((doc) {
        final data = doc.data();
        final ts = (data['updated'] as Timestamp?)?.toDate();
        if (ts == null || DateTime.now().difference(ts) > const Duration(minutes: 1)){
          return null;
        }
        return {
          'uid': data['uid'],
          'latitude': data['latitude'],
          'longitude': data['longitude'],
          'image': data['Gambar'],
        };
      })
          .whereType<Map<String, dynamic>>()
          .toList();
    });
  }

  Future<String?> getBarterImage(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('userLocation')
        .doc(uid)
        .get();

    if (!doc.exists) return null;

    final data = doc.data();
    if (data == null || data['Gambar'] == null || (data['Gambar'] as String).isEmpty) {
      return null;
    }

    return data['Gambar'] as String?;
  }



  Future<double> getBarterLatitude() async{
    final latitudeBarter = (await FirebaseFirestore.instance.collection('userLocation').doc(FirebaseAuth.instance.currentUser?.uid).get()).data()?['latitude'];
    return latitudeBarter;
  }

  Future<double> getBarterLongitude() async{
    final longitudeBarter = (await FirebaseFirestore.instance.collection('userLocation').doc(FirebaseAuth.instance.currentUser!.uid).get()).data()?['longitude'];
    return longitudeBarter;
  }

  Future<BitmapDescriptor> createCustomMarker(String imagerUrl) async {
    final response = await http.get(Uri.parse(imagerUrl));
    final Uint8List imageBytes = response.bodyBytes;
    final codec = await ui.instantiateImageCodec(imageBytes, targetWidth: 100);
    final frame = await codec.getNextFrame();
    final byteData = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());

  }

  Future<BitmapDescriptor> createCustomMarkerFromImage(
      String imageUrl, {int size = 150}) async {
    final response = await http.get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;

    final codec = await ui.instantiateImageCodec(
      bytes,
      targetWidth: size,
      targetHeight: size,
    );
    final frame = await codec.getNextFrame();
    final image = frame.image;

    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint()..isAntiAlias = true;

    // gambar lingkaran putih background
    canvas.drawCircle(
      Offset(size / 2, size / 2),
      size / 2,
      paint..color = const Color(0xFFFFFFFF),
    );

    // gambar foto user
    final src = Rect.fromLTWH(
      0,
      0,
      image.width.toDouble(),
      image.height.toDouble(),
    );
    final dst = Rect.fromLTWH(
      0,
      0,
      size.toDouble(),
      size.toDouble(),
    );
    canvas.drawImageRect(image, src, dst, paint);

    final markerImage =
    await pictureRecorder.endRecording().toImage(size, size);
    final byteData =
    await markerImage.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List resizedBytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(resizedBytes);
  }

}