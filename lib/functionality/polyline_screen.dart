import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(35.920834, 74.308334),
    zoom: 10,
  );

  List<LatLng> points = const [
    LatLng(35.920834, 74.308334),
    LatLng(32.337006, 74.903336),
    LatLng(32.166351, 74.195900),
    LatLng(31.582045, 74.329376),
    LatLng(33.626057, 73.071442),
  ];

  @override
  void initState() {
    super.initState();
    for(int i=0; i<points.length; i++){
      _markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            position: points[i],
            infoWindow: const InfoWindow(
              title: 'HOTEL',
              snippet: '5 Star Hotel',
            ),
            icon: BitmapDescriptor.defaultMarker,
          )
      );
      setState(() {

      });
      _polyline.add(
          Polyline(
            polylineId: const PolylineId('1'),
            points: points,
            color: Colors.red,
            width: 5
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: GoogleMap(
            initialCameraPosition: _kGoogle,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            markers: Set<Marker>.of(_markers),
            polylines: _polyline,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        ));
  }

}
