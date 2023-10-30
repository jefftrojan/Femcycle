import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontendsrc/brandkit/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class Locator extends StatefulWidget {
  const Locator({super.key});

  @override
  State<Locator> createState() => LocatorState();
}

class LocatorState extends State<Locator> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  final Location _location = Location();
  LocationData? _currentLocation;
  Set<Marker> _markers = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    loadEnvVariables(); 

  }

  Future<void> _getCurrentLocation() async {
    try {
      final locationData = await _location.getLocation();
      setState(() {
        _currentLocation = locationData;
      });
      _moveCameraToLocation(locationData.latitude!, locationData.longitude!);
      _getNearbyHospitals(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  Future<void> _moveCameraToLocation(double latitude, double longitude) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 15,
      ),
    ));
  }

  Future<void> _getNearbyHospitals(double latitude, double longitude) async {
    // Replace this with your logic to fetch nearby hospitals
    // Sample code to add some markers (you should fetch real hospital data)
    final markers = {
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(latitude + 0.001, longitude + 0.001),
        infoWindow: InfoWindow(title: ''),
      ),
      Marker(
        markerId: MarkerId('2'),
        position: LatLng(latitude - 0.002, longitude - 0.002),
        infoWindow: InfoWindow(title: ''),
      ),
      Marker(
        markerId: MarkerId('3'),
        position: LatLng(latitude + 0.003, longitude - 0.003),
        infoWindow: InfoWindow(title: ''),
      ),
    };
    setState(() {
      _markers = markers;
    });
  }
  
  Future<void> loadEnvVariables() async {
    await dotenv.load();
    setState(() {
      // The environment variables are now available.
      // You can access them here or in the build method.
    });
  }

  Future<void> _getDirections(double destinationLatitude, double destinationLongitude) async {
    if (_currentLocation != null) {
      final String apiKey = dotenv.env['mapsapi']!;
      final String origin = '${_currentLocation!.latitude},${_currentLocation!.longitude}';
      final String destination = '$destinationLatitude,$destinationLongitude';

      final Uri uri = Uri.https(
        'maps.googleapis.com',
        '/maps/api/directions/json',
        <String, String>{
          'origin': origin,
          'destination': destination,
          'key': apiKey,
        },
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final directions = jsonDecode(response.body);
        // Process the directions data and update the map accordingly
      } else {
        print('Failed to fetch directions: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
        onTap: (LatLng position) {
          // Handle map tap events, e.g., show hospital info or directions
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _getCurrentLocation,
      //   label: const Text('Find Hospitals Nearby'),
      //   icon: const Icon(Icons.local_hospital),
      // ),
      bottomNavigationBar: BottomNavBarFb3(),
      
    );
  }
}
