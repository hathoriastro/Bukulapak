import 'dart:async';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Completer<GoogleMapController> _controller = Completer();
  Position? _currentPosition;
  Set<Marker> _markers = {};
  StreamSubscription<QuerySnapshot>? _nearbyUsersSub;

  Future<void> _openWhatsApp(String phone, String? message) async {
    final pesan = message != null ? "?text=${Uri.encodeComponent(message)}" : "";
    final uri = Uri.parse('https://wa.me/$phone$pesan');
    final urlWeb = Uri.parse('https://web.whatsapp.com/send?phone=$phone$pesan');

    if (await canLaunchUrl(uri)) {
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (e){
        await launchUrl(urlWeb, mode: LaunchMode.externalApplication);
      }
    }else {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _listenNearbyUsers();
  }

  @override
  void dispose() {
    _nearbyUsersSub?.cancel();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = pos;
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(pos.latitude, pos.longitude), 14),
    );
  }

  Future<BitmapDescriptor> createCircularMarker(String imageUrl, {int size = 150}) async {
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

    final clipPath = Path()
      ..addOval(Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()));
    canvas.clipPath(clipPath);

    final src = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    final dst = Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble());
    canvas.drawImageRect(image, src, dst, paint);


    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.white
      ..strokeWidth = 6;
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2, paint);

    final markerImage = await pictureRecorder.endRecording().toImage(size, size);
    final byteData = await markerImage.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  void _listenNearbyUsers() {
    _nearbyUsersSub = _firestore.collection("userLocation").snapshots().listen(
          (snapshot) async {
        Set<Marker> newMarkers = {};


        if (_currentPosition != null) {
          var doc = await _firestore.collection('userLocation').doc(_auth.currentUser?.uid).get();
          final data = doc.data() as Map<String, dynamic>;
          newMarkers.add(
            Marker(
              markerId: const MarkerId("me"),
              position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
              infoWindow: const InfoWindow(title: "Lokasi Saya"),
              icon: await createCircularMarker(data['Gambar'])
            ),
          );
        }

        for (var doc in snapshot.docs) {
          if (doc.id == _auth.currentUser?.uid) continue; // skip diri sendiri

          final data = doc.data() as Map<String, dynamic>;
          final lat = data['latitude'];
          final lng = data['longitude'];

          if (lat != null && lng != null) {
            BitmapDescriptor icon = BitmapDescriptor.defaultMarker;


            if (data['Gambar'] != null && (data['Gambar'] as String).isNotEmpty) {
              try {
                icon = await createCircularMarker(data['Gambar']);
              } catch (e) {
                print("❌ gagal load gambar marker: $e");
              }
            }

            newMarkers.add(
              Marker(
                markerId: MarkerId(doc.id),
                position: LatLng(lat, lng),
                infoWindow: InfoWindow(title: data['Judul'] ?? "Buku"),
                icon: icon,
                onTap: () async {
                  final userDataDoc = await _firestore.collection("user").doc(doc.id).get();
                  final userData = userDataDoc.data() as Map<String, dynamic>;
                  if(userData != null) {
                    _showUserPopup(context, data, userData);
                  }
                },
              ),
            );
          }
        }

        setState(() {
          _markers = newMarkers;
        });
      },
    );
  }

  void _showUserPopup(BuildContext context, Map<String, dynamic> user, Map<String, dynamic> userData) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user['Gambar'] ?? ""),
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 16),
                Text(
                  user['Judul'] ?? "Buku",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${user['Penerbit'] ?? ''} | ${user['Kategori'] ?? ''}",
                  style: const TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    String formatPhone(String? phone){
                      if(phone == null || phone.isEmpty) return "";
                      if(phone.startsWith('0')){
                        return phone.replaceFirst('0', '62');
                      }
                      return phone;
                    }

                    final phone = userData['phone'] ?? "";
                    final String formattedPhone = formatPhone(phone);
                    if (formattedPhone.isNotEmpty) {
                      _openWhatsApp(formattedPhone, "Halo, saya tertarik dengan buku ${user['Judul'] ?? ''}");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Nomor WhatsApp user tidak tersedia")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("OKE"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          zoom: 14,
        ),
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
