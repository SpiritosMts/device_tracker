import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:device_track/screens/map_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../_models/device.dart';
import '../../_models/notif.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;

import '../bindings.dart';
import '../myUi.dart';
import '../myVoids.dart';
import '../styles.dart';

class LayoutCtr extends GetxController {
  String appBarText ='Home';//home
  List<Widget> appBarBtns=[];
  Widget leading=Container();



  @override
  onInit() {
    super.onInit();
    sharedPrefs!.reload();
    Future.delayed(const Duration(milliseconds: 50), ()  async {

      selectDevice(devices[0]);
    });
  }
  /// *************************************************************************************


  updateAppbar({String? title,Widget? ldng,List<Widget>? btns}){
    if(title!=null) appBarText = title;
    if(btns!=null) appBarBtns=btns;
    if(ldng!=null) leading=ldng;
    update();
  }

  onScreenSelected(int index){
    switch (index) {
      case 0:
        updateAppbar(title:'Home'.tr,
    ldng: Container(),

            btns: [
              IconButton(
                onPressed: () {
                  showAnimDialog(showAddDeviceDialog());

                },
                icon: Icon(Icons.add,color: appBarButtonsCol,),

              ),

        ]);

        refreshDevices();
        break;
      case 1:
        updateAppbar(title:'Graph'.tr,
            ldng: Container(),
            btns: [
              IconButton(
                onPressed: () {
                  showDatePicker();
                },
                icon: Icon(Icons.filter_alt_rounded,color: appBarButtonsCol,),

              ),
            ]
          );


        break;
      case 2:
        updateAppbar(title:'Map'.tr,btns: [
        ],ldng: Container());


        addMarkers();
        break;

      case 3:
        updateAppbar(title:'Notifications'.tr,btns: [],ldng: Container());

        break;


      default:
        updateAppbar(title:'Home'.tr,btns: [],ldng: Container());


    }
  }
/// *************************************************************************************

  static const token = 'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJEUk95dUhCcmhUY2hfMDVuUWlXNnphZkpFNWlQRDYwbl9zUllmSXNLdmY4In0.eyJleHAiOjE3MTYwODY2NDksImlhdCI6MTcxNjA1MDY0OSwianRpIjoiODdlYzM3NDAtZWZhMS00MzBjLThmNzAtZjZmM2YxMTU4YzZlIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgxL3JlYWxtcy9CV1MiLCJhdWQiOiJhY2NvdW50Iiwic3ViIjoiYjAzYTY5NmYtOWQzMy00ZTQxLTliOWMtYzFlYTk0NTQ4ODg0IiwidHlwIjoiQmVhcmVyIiwiYXpwIjoiUEZFIiwic2Vzc2lvbl9zdGF0ZSI6ImVmNmZjZmFmLTdhOGMtNDM4Yy1hNTNlLWQ3Njc3MmFhM2Q1MiIsImFjciI6IjEiLCJhbGxvd2VkLW9yaWdpbnMiOlsiKiJdLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsib2ZmbGluZV9hY2Nlc3MiLCJkZWZhdWx0LXJvbGVzLWJ3cyIsInVtYV9hdXRob3JpemF0aW9uIiwiQ2xpZW50IiwiQWRtaW4iXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6ImVtYWlsIHByb2ZpbGUiLCJzaWQiOiJlZjZmY2ZhZi03YThjLTQzOGMtYTUzZS1kNzY3NzJhYTNkNTIiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwibmFtZSI6IlJpYWRoIFRhcmhvdW5pIiwicHJlZmVycmVkX3VzZXJuYW1lIjoicmlhZGgiLCJnaXZlbl9uYW1lIjoiUmlhZGgiLCJmYW1pbHlfbmFtZSI6IlRhcmhvdW5pIiwiZW1haWwiOiJyYWlkaHRyMjFAZ21haWwuY29tIn0.fZWFUuK01jn0gm6yTle_dcpdEgtkaSCY7lxzlhs8-UZxB0MwG4F5tAd7YRWLmNnfCkljK6UTeN94Zd5yjnBS63e50uKGhCzUvuF8lGTdlgrptOC1NL7jKpq-CB9avWdCYtHpWhFnEYeo6bbmMSV9J4nzyf0fv8-S4T7r7L8Drv04K7Zr1fG9duP_NynmfKOzx295HxOtos4IT0_AYMNr5ngla2z203zs7Zuo16dpqfY-rD8YS9hN0gyqJTMmXtFOoWklzNsJwlK5-oLBfW7IAydyE-GIyPPXREUCXNAU-vNi8L6WHPuuy7WMazwn2gKF-_d6186D9xmIMtyWJwJJBg';

  Map<String,dynamic> headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  String endpointNtif = 'https://api.example.com/data';


  Future<dynamic> makeHttpRequest({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);

    try {
      final response = await http.get(uri, headers: headers);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Decode the JSON response body
        final decodedData = jsonDecode(response.body);
        return decodedData;
      } else {
        throw Exception('## Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('## Failed to make request: $e');
    }
  }


  

List<Notif> notifs = [];

  List<DeviceModel> devices = [
    DeviceModel(
      device: Devicee(
        adresse: 0,
        name: 'Sensor 1',
        description: 'Description 1',
        type: 0,
        region: 'Region 1',
        seuil: 10,
      ),
      latitude: 34.8393437,
      longitude:  10.7574046,
      energy: '100 kWh',
      emission: '80',
      money: '86.784',
      flSpots: generateRandomSpots( 10, 80),
    ),
    DeviceModel(
      device: Devicee(
        adresse: 1,
        name: 'Sensor 2',
        description: 'Description 2',
        type: 1,
        region: 'Region 2',
        seuil: 20,
      ),
      latitude: 48.8645703,
      longitude:  2.3489013,
      energy: '200 kWh',
      emission: '66',
      money: '32.002',
      flSpots: generateRandomSpots( 10, 80),
    ),
    DeviceModel(
      device: Devicee(
        adresse: 2,
        name: 'Sensor 3',
        description: 'Description 3',
        type: 2,
        region: 'Region 3',
        seuil: 30,
      ),
      latitude: 35.8200,
      longitude: 10.6450,
      energy: '300 kWh',
      emission: '57',
      money: '50.152',
      flSpots: generateRandomSpots( 10, 80),
    ),
  ];

  Future<void> refreshNotifs() async {
    print('## refreshNotifs ....');
    final String endpoint = 'http://localhost:8080/Notification_alerte/ALL';
    String jsonDataNotif = '''
  [
    {
      "id": 2,
      "timestamp": "2024-05-16T16:45:22.123",
      "id_device": 2,
      "type_alerte": "High Consumption",
      "gravite": "MEDIUM",
      "description_alerte": "Consommation supérieure au seuil: 10.0"
    },
    {
      "id": 2,
      "timestamp": "2024-05-17T10:30:45.567",
      "id_device": 2,
      "type_alerte": "High Consumption",
      "gravite": "MEDIUM",
      "description_alerte": "Consommation supérieure au seuil: 10.0"
    }
  ]
  ''';
    try {
      //final response = await makeHttpRequest(endpoint: endpoint);
      //final List<dynamic> jsonData = jsonDecode(response.body);//dynamic
      final List<dynamic> jsonData = jsonDecode(jsonDataNotif);//static

      notifs = jsonData.map((notifData) => Notif.fromJson(notifData)).toList();
      update();

    } catch (e) {
      print('## Error fetching notifications: $e');
    }

  }
  Future<void> refreshDevices() async {
    print('## refreshDevices ....');
    final String endpoint = 'http://localhost:8080/Devices/all';
    String jsonDataDevices = '''
  
  ''';
    try {
      //final response = await makeHttpRequest(endpoint: endpoint);

      //final List<dynamic> jsonData = jsonDecode(response.body);//dynamic
      //final List<dynamic> jsonData = jsonDecode(jsonDataDevices);//static

      //devices = jsonData.map((data) => DeviceModel.fromJson(data)).toList();
      update();

    } catch (e) {
      print('## Error fetching devices: $e');
    }

  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final adresseTec = TextEditingController();
  final typeTec = TextEditingController();
  final seuilTec = TextEditingController();
  final nameTec = TextEditingController();
  final descriptionTec = TextEditingController();
  final regionTec = TextEditingController();
  double lat = 0;
  double lng = 0;
  void resetValues() {
    adresseTec.clear();
    typeTec.clear();
    seuilTec.clear();
    nameTec.clear();
    descriptionTec.clear();
    regionTec.clear();
    lat = 0;
    lng = 0;
    update(); // Notify listeners to update the UI
  }
  final Completer<GoogleMapController> mapController = Completer();
  late GoogleMapController gglMapCtr;

  void onMapCreated(GoogleMapController controller) {
    gglMapCtr = controller;
  }

  DeviceModel selectedDevice = DeviceModel(device: Devicee());

  selectDevice(DeviceModel device){
    selectedDevice = device;
    update();
  }

  jumpTochart(){
    authCtr.layoutViewCtr.jumpToTab(1);
    onScreenSelected(2);
  }
  void jumpToLoc(lat, lng) {
    print('## jumping to location....');

    authCtr.layoutViewCtr.jumpToTab(2);
    onScreenSelected(2);

    gglMapCtr.animateCamera(

      CameraUpdate.newLatLngZoom(LatLng(lat, lng), 15), // Adjust the zoom level as needed
    );
    update();
  }
  void showMapScreen() async {
    final result = await Get.to(() => MapScreePicker());
    if (result != null) {
       lat = result['latitude'];
       lng = result['longitude'];
      // Use the latitude and longitude as needed
    }
  }
  void updateLocation(LatLng position) {
    lat = position.latitude;
    lng = position.longitude;
    print('## loc = $lat , $lng');
    update(); // Notify listeners to update the UI
  }
  showAddDeviceDialog(){
    return AlertDialog(
      backgroundColor: dialogBgCol,
      title: Text(
        'Add New Device'.tr,
        style: TextStyle(
          color: dialogTitleCol,
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: GetBuilder<LayoutCtr>(
          initState: (_) {

          },
          dispose: (_) {
          },
          builder: (_) => SingleChildScrollView(
            child: Form(
              key: formKey,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  SizedBox(height: 18),
                  customTextField(
                    controller: nameTec,
                    labelText: 'Name'.tr,
                    icon: Icons.device_hub,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 18),
                  customTextField(
                    controller: seuilTec,
                    labelText: 'Seuil'.tr,
                    icon: Icons.speed,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Seuil is required';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Seuil must be an integer';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  customTextField(

                    controller: adresseTec,
                    labelText: 'Adresse'.tr,
                    icon: Icons.location_on,

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      if (int.tryParse(value) == null) {
                        return 'Adresse must be an integer';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 18),
                  customTextField(
                    controller: typeTec,
                    labelText: 'Type'.tr,
                    icon: Icons.category,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      }
                      if (int.tryParse(value) == null) {
                        return 'Type must be an integer';
                      }
                      return null;
                    },
                  ),


                  SizedBox(height: 18),
                  customTextField(
                    controller: descriptionTec,
                    labelText: 'Description'.tr,
                    icon: Icons.description,

                  ),
                  SizedBox(height: 18),
                  customTextField(
                    controller: regionTec,
                    labelText: 'Region'.tr,
                    icon: Icons.map,

                  ),
                  SizedBox(height: 18),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          style: borderBtnStyle(),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Cancel".tr,
                            style: TextStyle(color: dialogBtnCancelTextCol),
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          height: 50,

                          child: TextButton(
                            style: filledBtnStyle(),
                            onPressed: () {
                              showMapScreen();
                            },
                            child: Icon(
                              Icons.add_location_alt_sharp,color: Colors.white,size: 25,


                            ),
                          ),
                        ),
                        TextButton(
                          style: filledBtnStyle(),
                          onPressed: () {
                            addDeviceApi();
                          },
                          child: Text(
                            "Add".tr,
                            style: TextStyle(color: dialogBtnOkTextCol),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );

  }
  addDeviceApi(){
    if (formKey.currentState!.validate()) {

      if(lat==0.0 && lng==0.0){
        showSnack('Select Location');

        return;
      }

      Devicee newDevice = Devicee(
        adresse: int.tryParse(adresseTec.text)??0,
        type: int.tryParse(typeTec.text) ?? 0, // Parse type as int or default to 0
        name: nameTec.text,
        description: descriptionTec.text,
        region: regionTec.text,
        seuil: int.tryParse(seuilTec.text) ?? 0, // Parse seuil as int or default to 0
      );

     DeviceModel newDev =DeviceModel(
       device: newDevice,
       latitude: lat,
       longitude: lng
     );

      devices.add(newDev);
      update();



      //success
      showTos('Device added successfully',color: Colors.green);
      resetValues();
      Get.back();
    }
  }


  ///******************  MAP *******************

  final List<Marker> markers = [];
  void addMarkers() {
    List<LatLng> positions = [];
    for (var deviceModel in devices) {
      positions.add(LatLng(deviceModel.latitude, deviceModel.longitude));
    }
    // List<LatLng> positions = [
    //   LatLng(34.8393437, 10.7574046),
    //   LatLng(48.8645703, 2.3489013),
    //   LatLng(35.8200, 10.6450),
    //   LatLng(35.8270, 10.6350),
    //   LatLng(35.8230, 10.6420),
    // ];


    markers.clear();
    for (int i = 0; i < positions.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('marker_$i'),
          position: positions[i],
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          infoWindow: InfoWindow(

            title: devices[i].device.name,
            //snippet: 'This is marker number $i',
          ),
        ),
      );
    }

update();
    print('## markers added');
  }

  ///*******************  GRAPH ***********************
  DateTime startDate = DateTime(2000, 1, 1) ;
  DateTime endDate=DateTime(2000, 1, 1) ;

  void showDatePicker() {
    DatePicker.showDatePicker(
      navigatorKey.currentContext!,
      showTitleActions: true,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime(2100, 12, 31),
      onConfirm: (date) {

          startDate = date;
          update();

          showEndDatePicker();
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }

  void showEndDatePicker() {
    DatePicker.showDatePicker(
      navigatorKey.currentContext!,
      showTitleActions: true,
      minTime: startDate ?? DateTime.now(),
      maxTime: DateTime(2100, 12, 31),
      onConfirm: (date) {
          endDate = date;
          update();
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }
  List<FlSpot> spots = List.generate(
    15,
        (index) => FlSpot(index.toDouble(), (index * 5 + 20) % 100.toDouble()),
  );


  void updateSpots() {
      spots = List.generate(
        15,
            (index) => FlSpot(index.toDouble(), (index * 10 + 30) % 100.toDouble()),
      );

      update();
  }
}
List<FlSpot> generateRandomSpots( double minY, double maxY) {
  final random = Random();
  return List.generate(
    15,
        (index) => FlSpot(
      index.toDouble(),
      minY + random.nextDouble() * (maxY - minY),
    ),
  );
}