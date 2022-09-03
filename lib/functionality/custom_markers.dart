import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkers extends StatefulWidget {
  const CustomMarkers({Key? key}) : super(key: key);

  @override
  State<CustomMarkers> createState() => _CustomMarkersState();
}

class _CustomMarkersState extends State<CustomMarkers> {
  final Completer<GoogleMapController> _controller = Completer();

  // on below line we are specifying our camera position
  final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(31.582045, 74.329376),
    zoom: 6,
  );
  Uint8List? marketimages;
  List<String> images = ['assets/images/car.png','assets/images/car.png', 'assets/images/car.png', 'assets/images/car.png', 'assets/images/car.png'];


  // on below line we have created list of markers
  late List<Marker> _marker;
  List<LatLng> listLatLng = const [
    LatLng(35.920834, 74.308334),
    LatLng(32.337006, 74.903336),
    LatLng(32.166351, 74.195900),
    LatLng(31.582045, 74.329376),
    LatLng(33.626057, 73.071442),
  ];

  @override
  void initState() {
    _marker = [];
    loadData();
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

  // declared method to get Images
  Future<Uint8List> getImages(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  loadData() async{
    for(int i=0 ;i<images.length; i++){
      final Uint8List markIcons = await getImages(images[i], 100);
      // makers added according to index
      _marker.add(
          Marker(
            // given marker id
            markerId: MarkerId(i.toString()),
            // given marker icon
            icon: BitmapDescriptor.fromBytes(markIcons),
            // given position
            position: listLatLng[i],
            infoWindow: InfoWindow(
              // given title for marker
              title: 'Location: '+i.toString(),
            ),
          )
      );
      setState(() {
      });
    }
  }

}
