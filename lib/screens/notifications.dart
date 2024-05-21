import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../_manager/bindings.dart';
import '../_manager/generalLayout/generalLayoutCtr.dart';
import '../_manager/myUi.dart';
import '../_manager/styles.dart';
import '../_models/notif.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
                  child:layCtr.notifs.isNotEmpty? ListView.builder(
                    //  physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 20,
                        right: 0,
                        left: 0,
                      ),
                      //itemExtent: 100,// card height
                      itemCount: layCtr.notifs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Notif usr = (layCtr.notifs[index]);
                        return notifCard(usr, index );
                      }
                  ):Center(child: Text('No Notifications to show',style: TextStyle(fontSize: 16,color: normalTextCol)),),
                ),
              )
            ],
          ),
        );
      }),

    );
  }
}
