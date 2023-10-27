import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class NearbyHospitalsScreen extends StatefulWidget {
  @override
  _NearbyHospitalsScreenState createState() => _NearbyHospitalsScreenState();
}

class _NearbyHospitalsScreenState extends State<NearbyHospitalsScreen> {
  late GoogleMapController _mapController;
  late Location _location;
  LocationData? _currentLocation;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _location = Location();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
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
    final cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 15,
    );
    _mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<void> _getNearbyHospitals(double latitude, double longitude) async {
    // Make API call to get nearby hospitals using latitude and longitude
    // Here, we are just adding some sample markers to show how it works
    final markers = {
      Marker(
        markerId: MarkerId('1'),
        position: LatLng(latitude + 0.001, longitude + 0.001),
        infoWindow: InfoWindow(title: 'Hospital 1'),
      ),
      Marker(
        markerId: MarkerId('2'),
        position: LatLng(latitude - 0.002, longitude - 0.002),
        infoWindow: InfoWindow(title: 'Hospital 2'),
      ),
      Marker(
        markerId: MarkerId('3'),
        position: LatLng(latitude + 0.003, longitude - 0.003),
        infoWindow: InfoWindow(title: 'Hospital 3'),
      ),
    };
    setState(() {
      _markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Hospitals'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              _getCurrentLocation();
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(37.77483, -122.41942),
              zoom: 15,
            ),
            mapType: MapType.normal, // Add your desired map type here
            markers: _markers,
          ),
          Positioned(
            top: 16,
            left: 16,
            child: FloatingActionButton(
              onPressed: () {
                _getCurrentLocation();
              },
              child: Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
