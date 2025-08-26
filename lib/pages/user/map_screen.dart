import 'package:bukulapak/services/map_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapScreen extends StatefulWidget {
  const mapScreen({super.key});
  
  @override
  State<mapScreen> createState() => _mapScreenState();
}

class _mapScreenState extends State<mapScreen> {
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    final customIcon = await _mapServices.createCustomMarker(
        "https://firebasestorage.googleapis.com/v0/b/naru-c8575.appspot.com/o/images%2F1756101640498.png?alt=media&token=a6a096a9-d418-4467-9dea-8a1e81fb75cd"
    );

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("customMarker"),
          position: LatLng(-7.95, 112.61),
          icon: customIcon,
        ),
      );
    });
  }

  MapServices _mapServices = MapServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Maps"), centerTitle: true),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-7.95, 112.61),
          zoom: 14,
        ),
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
