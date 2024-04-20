import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    const CameraPosition tomskRegion = CameraPosition(
      target: LatLng(56.483242, 84.959140),
      zoom: 14,
    );

    return const Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: tomskRegion,
        ),
      ),
    );
  }
}
