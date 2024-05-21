import 'package:device_track/_models/device.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../_manager/bindings.dart';
import '../_manager/generalLayout/generalLayoutCtr.dart';
import '../_manager/myUi.dart';
import '../_manager/styles.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgCol,
      child: GetBuilder<LayoutCtr>(

          initState: (_){
            layCtr.refreshNotifs();
          },
          builder: (_) {

            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: 20,),
                  Expanded(
                    child: Container(
                      child:layCtr.devices.isNotEmpty? ListView.builder(
                        //  physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 20,
                            right: 0,
                            left: 0,
                          ),
                          //itemExtent: 100,// card height
                          itemCount: layCtr.devices.length,
                          itemBuilder: (BuildContext context, int index) {
                            DeviceModel usr = (layCtr.devices[index]);
                            return deviceeCard(usr, index );
                          }
                      ):Center(child: Text('No Devices to show',style: TextStyle(fontSize: 16,color: normalTextCol)),),
                    ),
                  )
                ],
              ),
            );
          }),

    );
  }
}
