import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LiveLocation extends StatefulWidget {
  @override
  State<LiveLocation> createState() => LiveLocationState();
}

class LiveLocationState extends State<LiveLocation> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _latLng;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();
    try {
      LocationData _locationData = await location.getLocation();
      _latLng = LatLng(_locationData.latitude!, _locationData.longitude!);
      print(_latLng);
      CameraPosition _kGooglePlex = CameraPosition(
        target: _latLng!,
        zoom: 14.0,
      );
      await Future.delayed(const Duration(seconds: 1));
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Live Location",
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white54,
        ),
        body: GoogleMap(
          buildingsEnabled: true,
          trafficEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(28.6289206, 77.2065322),
            zoom: 14.0,
          ),
          markers: _latLng != null ? {_setMarker()} : {},
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: Text("Share Live Location"),
        ),
      ),
    );
  }

  Marker _setMarker() {
    return Marker(
      markerId: MarkerId("marker_1"),
      icon: BitmapDescriptor.defaultMarker,
      position: _latLng!,
    );
  }
}
