import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const CameraPosition tomskRegion = CameraPosition(
      target: LatLng(56.483242, 84.959140),
      zoom: 14,
    );

    // Создаем список маркеров
    final List<Marker> markers = [
      const Marker(
        markerId: MarkerId('1'),
        position: LatLng(56.462317, 84.969289),
        infoWindow: InfoWindow(
          title: 'Lida',
          snippet: '23 мая 19:00',
        ),
        icon: BitmapDescriptor.defaultMarker, // Иконка маркера
      ),
      const Marker(
        markerId: MarkerId('2'),
        position: LatLng(56.486873, 84.949375),
        infoWindow: InfoWindow(
          title: 'Лебединое озеро',
          snippet: '9 июля 19:00',
        ),
        icon: BitmapDescriptor.defaultMarker, // Иконка маркера
      ),
      const Marker(
        markerId: MarkerId('3'),
        position: LatLng(56.487031, 84.947079),
        infoWindow: InfoWindow(
          title: 'Другая жизнь',
          snippet: '23 мая 19:00',
        ),
        icon: BitmapDescriptor.defaultMarker, // Иконка маркера
      ),
      const Marker(
        markerId: MarkerId('4'),
        position: LatLng(56.459262, 84.972177),
        infoWindow: InfoWindow(
          title: 'Сергей Орлов',
          snippet: '25 мая 19:00',
        ),
        icon: BitmapDescriptor.defaultMarker, // Иконка маркера
      ),
      const Marker(
        markerId: MarkerId('5'),
        position: LatLng(56.462317, 84.969289),
        infoWindow: InfoWindow(
          title: 'Lida',
          snippet: '23 мая 19:00',
        ),
        icon: BitmapDescriptor.defaultMarker, // Иконка маркера
      ),
      const Marker(
        markerId: MarkerId('6'),
        position: LatLng(56.469112, 84.946865),
        infoWindow: InfoWindow(
          title: 'Не майся! Улыбайся',
          snippet: '28 мая 19:00',
        ),
        icon: BitmapDescriptor.defaultMarker, // Иконка маркера
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: tomskRegion,
          markers: Set<Marker>.of(markers), // Устанавливаем маркеры на карту
        ),
      ),
    );
  }
}
