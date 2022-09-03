import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/functionality/current_location.dart';
import 'package:google_maps/functionality/custom_markers.dart';
import 'package:google_maps/functionality/latlng_address.dart';
import 'package:google_maps/functionality/multiple_markers.dart';
import 'package:google_maps/functionality/polyline_screen.dart';
import 'package:google_maps/functionality/suggestion_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'functionality/polygon_area.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:const Text("Select Maps Functionality"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const CurrentLocation()));
              }, child: const Text("Current Location")),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const CustomMarkers()));
              }, child: const Text("Custom Markers")),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const MultipleMarkers()));
              }, child: const Text("Multiple Markers")),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const LatLngAddress()));
              }, child: const Text("LatLng Address")),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const SuggestionPlaces()));
              }, child: const Text("Places Api")),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const PolygonScreen()));
              }, child: const Text("Polygon")),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const PolylineScreen()));
              }, child: const Text("Polyline")),
            ],
          ),
        ),
      ),
    );
  }

}
