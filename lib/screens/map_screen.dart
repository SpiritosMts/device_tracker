import 'package:device_track/_manager/generalLayout/generalLayoutCtr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../_manager/bindings.dart';
import '../_manager/styles.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {


  final LatLng _center = LatLng(35.8256, 10.6411); // Center of Sousse



  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgCol,
child: GetBuilder<LayoutCtr>(
  initState: (_){
  },
  builder: (context) {
    return     GoogleMap(

      onMapCreated: layCtr.onMapCreated,

      initialCameraPosition: CameraPosition(

        target: _center,

        zoom: 14.0,

      ),

      markers: Set<Marker>.of(layCtr.markers),

    );
  }
),
    );
  }
}

/// pick location ///////////////////////:

class MapScreePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutCtr>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Select Location',style: TextStyle(
              fontWeight: FontWeight.w500,
              color: appBarTitleColor,
            ),
            ),
            centerTitle: true,
            backgroundColor: appBarBgColor,
            bottom: appBarUnderline(),
          ),
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: (GoogleMapController mapController) {
                  layCtr.mapController.complete(mapController);
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(layCtr.lat, layCtr.lng),
                  zoom: 10,
                ),
                markers: {
                  if (layCtr.lat != 0 && layCtr.lng != 0)
                    Marker(
                      markerId: MarkerId('selected_location'),
                      position: LatLng(layCtr.lat, layCtr.lng),
                    ),
                },
                onTap: (position) {
                  layCtr.updateLocation(position);
                },
              ),
              Positioned(
                bottom: 20.0,
                left: MediaQuery.of(context).size.width * 0.25,
                right: MediaQuery.of(context).size.width * 0.25,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Get.back(result: {
                      'latitude': layCtr.lat,
                      'longitude': layCtr.lng,
                    });
                  },

                  label: Text('Save'),
                  icon: Icon(Icons.check),
                  backgroundColor: primaryColor, // Change the background color here
                  foregroundColor: Colors.white, // Change the text and icon color here

                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
