import 'package:bukulapak/services/map_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> _markers = {};
  final MapServices _mapServices = MapServices();

  @override
  void initState() {
    super.initState();
    _loadCurrentUserMarker();
    _listenNearbyUsers();
  }

  /// 🔹 Marker untuk user sendiri
  Future<void> _loadCurrentUserMarker() async {
    final barterImage =
    await _mapServices.getBarterImage(FirebaseAuth.instance.currentUser!.uid);

    if (barterImage != null) {
      final customIcon = await _mapServices.createCustomMarker(barterImage);

      final lat = await _mapServices.getBarterLatitude();
      final long = await _mapServices.getBarterLongitude();

      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId("userLocation"),
            icon: customIcon,
            position: LatLng(lat, long),
          ),
        );
      });
    }
  }

  /// 🔹 Marker untuk nearby users
  void _listenNearbyUsers() {
    _mapServices.getNearbyUsersWithLocation().listen((users) async {
      Set<Marker> newMarkers = {};

      for (var user in users) {
        if (user['latitude'] == null || user['longitude'] == null) continue;

        BitmapDescriptor icon = BitmapDescriptor.defaultMarker;
        if (user['image'] != null && (user['image'] as String).isNotEmpty) {
          icon = await _mapServices.createCustomMarkerFromImage(user['image']);
        }

        newMarkers.add(
          Marker(
            markerId: MarkerId(user['uid']),
            position: LatLng(user['latitude'], user['longitude']),
            icon: icon,
            infoWindow: InfoWindow(title: "User: ${user['uid']}"),
          ),
        );
      }

      setState(() {
        // jangan hapus marker user sendiri
        _markers.removeWhere((m) => m.markerId.value != "userLocation");
        _markers.addAll(newMarkers);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Maps"), centerTitle: true),
      body: FutureBuilder(
        future: Future.wait([
          _mapServices.getBarterLatitude(),
          _mapServices.getBarterLongitude(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final lat = snapshot.data![0] as double?;
          final long = snapshot.data![1] as double?;

          if (lat == null || long == null) {
            return const Center(child: Text("Lokasi tidak ditemukan"));
          }

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, long),
              zoom: 14,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          );
        },
      ),
    );
  }
}
