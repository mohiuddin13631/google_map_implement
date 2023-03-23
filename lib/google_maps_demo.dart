import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng _workLocation = LatLng(23.75059273477757, 90.39311329292313);
const LatLng homeLocation = LatLng(23.754279, 90.378779);


class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kLake = CameraPosition(
      target: _workLocation,
      zoom: 20);

  static const CameraPosition _home = CameraPosition(
      target: homeLocation,
      zoom: 18);

  static const CameraPosition _work = CameraPosition(
      target: _workLocation,
      zoom: 18);


  Map<String,Marker> _markers = {};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: _home,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            addMarker('home', homeLocation,"Home");
          },

          markers: _markers.values.toSet(),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              _goToTheWork();
              addMarker("work", _workLocation,"work");
            },
            label: const Text('work'),
            icon: const Icon(Icons.work),
          ),
          SizedBox(height: 10,),
          FloatingActionButton.extended(
            onPressed: () {
              _goToTheHome();
              addMarker("work", homeLocation,"Home");
            },
            label: const Text('Home'),
            icon: const Icon(Icons.home),
          ),
        ],
      )
    );
  }

  Future<void> _goToTheWork() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_work));
  }
  Future<void> _goToTheHome() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_home));
  }
  //todo: if you wont more location add here

  addMarker(String id,LatLng location,String title) async{//todo maker

    //todo: asset img
    final markerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(200, 200)), 'assets/images/pic_100x100.png',);

    //todo: Network img
    var url = 'https://www.nicepng.com/png/full/182-1829287_cammy-lin-ux-designer-circle-picture-profile-girl.png';
    var byte = (await NetworkAssetBundle(Uri.parse(url)).load(url)).buffer.asUint8List();
    final networkIcon = BitmapDescriptor.fromBytes(byte);


    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
      infoWindow: InfoWindow(title: title),
      // icon: networkIcon,
      icon: markerIcon,
    );
    _markers[id] = marker;
    setState(() {});
  }
}