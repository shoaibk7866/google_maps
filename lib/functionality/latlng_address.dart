import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LatLngAddress extends StatefulWidget {
  const LatLngAddress({Key? key}) : super(key: key);

  @override
  State<LatLngAddress> createState() => _LatLngAddressState();
}

class _LatLngAddressState extends State<LatLngAddress> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = [];
  final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );
  Set<Circle>? circles = {
    Circle(
      circleId: const CircleId("1"),
      center: LatLng(20.42796133580664, 80.885749655962),
      radius: 2000,
      fillColor: Colors.blue.shade100.withOpacity(0.5),
      strokeColor: Colors.blue.shade100,
      strokeWidth: 2,
    )
  };
  String? _currentAddress;
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.location_searching_rounded),
        onPressed: () async {
          _getCurrentPosition();
        },
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGoogle,
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            circles: circles!,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
                height: 80,
                color: Colors.white,
                child: Center(child: Text("Address= ${_currentAddress??""}",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),
                ))),
          )
        ],
      ),
    ));
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      //region Getting LatLng from current Address
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng(_currentPosition!);
      //endregion

      _markers.add(Marker(
        markerId: const MarkerId("2"),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(
          title: 'My Current Location',
        ),
      ));
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 13,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      circles = {
        Circle(
          circleId: const CircleId("1"),
          center: LatLng(position.latitude, position.longitude),
          radius: 2000,
          fillColor: Colors.blue.shade100.withOpacity(0.5),
          strokeColor: Colors.blue.shade100,
          strokeWidth: 2,
        )
      };
      setState(() {});
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
