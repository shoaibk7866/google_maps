import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({Key? key}) : super(key: key);

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

//region Polygon
/*
* Polygon is a shape that represents or highlight Places that exist inside LatLng.
* For example Boundry of one city, of one country
* */
//endregion

class _PolygonScreenState extends State<PolygonScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Polygon> _polygon = HashSet<Polygon>();

  // on below line we have set the camera position
  final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(35.920834, 74.308334),
    zoom: 10,
  );

  // created list of locations to display polygon
  List<LatLng> points = const [
    LatLng(35.920834, 74.308334),
    LatLng(32.337006, 74.903336),
    LatLng(32.166351, 74.195900),
    LatLng(31.582045, 74.329376),
    LatLng(33.626057, 73.071442),
  ];

  @override
  void initState() {
    _polygon.add(
        Polygon(
          // given polygonId
          polygonId: const PolygonId('1'),
          // initialize the list of points to display polygon
          points: points,
          // given color to polygon
          fillColor: Colors.green.withOpacity(0.3),
          // given border color to polygon
          strokeColor: Colors.green,
          geodesic: true,
          // given width of border
          strokeWidth: 4,
        )
    );
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
            polygons: _polygon,
            // displayed google map
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        )
    );
  }
}
