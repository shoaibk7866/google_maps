import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MultipleMarkers extends StatefulWidget {
  const MultipleMarkers({Key? key}) : super(key: key);

  @override
  State<MultipleMarkers> createState() => _MultipleMarkersState();
}

class _MultipleMarkersState extends State<MultipleMarkers> {
  final Completer<GoogleMapController> _controller = Completer();

  // on below line we are specifying our camera position
  final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(31.582045, 74.329376),
    zoom: 6,
  );

  // on below line we have created list of markers
  late List<Marker> _marker;
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(35.920834, 74.308334),
        infoWindow: InfoWindow(
          title: 'My Position',
        )
    ),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(32.337006, 74.903336),
        infoWindow: InfoWindow(
          title: 'Location 1',
        )
    ),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(32.166351, 74.195900),
        infoWindow: InfoWindow(
          title: 'Location 2',
        )
    ),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(31.582045, 74.329376),
        infoWindow: InfoWindow(
          title: 'Location 2',
        )
    ),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(33.626057, 73.071442),
        infoWindow: InfoWindow(
          title: 'Location 2',
        )
    ),
  ];

  @override
  void initState() {
    _marker = [];
    _marker.addAll(_list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: GoogleMap(
            //given camera position
            initialCameraPosition: _kGoogle,
            // on below line we have given map type
            mapType: MapType.normal,
            // on below line we have enabled location
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            // on below line we have enabled compass location
            compassEnabled: true,
            // on below line we have added polygon
            markers: Set<Marker>.of(_marker),
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        ));
  }
}
