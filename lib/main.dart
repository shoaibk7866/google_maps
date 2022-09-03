import 'package:flutter/material.dart';
import 'package:google_maps/functionality/current_location.dart';
import 'package:google_maps/functionality/custom_markers.dart';
import 'package:google_maps/functionality/latlng_address.dart';
import 'package:google_maps/functionality/polygon_area.dart';
import 'package:google_maps/functionality/polyline_screen.dart';
import 'package:google_maps/functionality/suggestion_places.dart';
import 'package:google_maps/home_screen.dart';

void main() {
  runApp(const MyApp());
}

//region How to setup google map in project
/*
* First go to this url https://console.cloud.google.com/google/maps-apis/credentials?project=flutter-map-testing-359116&supportedpurview=project
* and enable google map sdk for android and also for ios. after that go to credentials and make your api key.
* install google_map package flutter.dev wala. Now add api key inside menifest also in
* AppDelegate.swift inside runner and import Google map also inside this file.
* */
//endregion

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }

}
