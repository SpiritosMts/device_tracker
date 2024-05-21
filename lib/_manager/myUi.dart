import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:device_track/_manager/bindings.dart';
import 'package:device_track/_models/device.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../_models/notif.dart';
import 'myVoids.dart';
import 'styles.dart';






notifCard(Notif notif, int i, {bool tappable = true, bool canDelete = true, Function()? btnOnPress}) {
  double bottomProdName = 9;
  double bottomProdBuy = 6;

  return GestureDetector(
    onTap: () {
      if (tappable) {

      }
    },
    child: Container(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: productBorderCol, width: 1.5), borderRadius: BorderRadius.circular(13)),
        color: productCardColor,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      /// ICON
                      Icon(
                        Icons.notifications,
                        color: Colors.yellow[700],
                        size: 40,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: bottomProdName, top: 5),
                            child: Text('${notif.typeAlerte}', style: TextStyle(
                                color: normalTextCol,
                                fontWeight: FontWeight.w400,
                                fontSize: 17
                            )),
                          ),

                          /// Timestamp
                          Padding(
                            padding: EdgeInsets.only(bottom: bottomProdBuy),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Timestamp:',
                                    style: GoogleFonts.almarai(
                                      height: 1,
                                      textStyle: TextStyle(color: transparentTextCol, fontSize: 13, fontWeight: FontWeight.w500),
                                    )),
                                TextSpan(
                                    text: '  ${notif.timestamp}',
                                    style: GoogleFonts.almarai(
                                      height: 1,
                                      textStyle: TextStyle(
                                          color: blueCol,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    )),
                              ]),
                            ),
                          ),
                          /// Gravite
                          Padding(
                            padding: EdgeInsets.only(bottom: bottomProdBuy),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Gravite:',
                                    style: GoogleFonts.almarai(
                                      height: 1,
                                      textStyle: TextStyle(color: transparentTextCol, fontSize: 13, fontWeight: FontWeight.w500),
                                    )),
                                TextSpan(
                                    text: '  ${notif.gravite}',
                                    style: GoogleFonts.almarai(
                                      height: 1,
                                      textStyle: TextStyle(
                                          color: blueCol,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    )),
                              ]),
                            ),
                          ),
                          /// Description
                          Padding(
                            padding: EdgeInsets.only(bottom: bottomProdBuy),
                            child: SizedBox(
                              width: 60.w,
                              child: RichText(
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.visible, // Set overflow to visible

                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Description:',
                                      style: GoogleFonts.almarai(
                                        height: 1,
                                        textStyle: TextStyle(color: transparentTextCol, fontSize: 13, fontWeight: FontWeight.w500),
                                      )),
                                  TextSpan(
                                      text: '  ${notif.descriptionAlerte}',
                                      style: GoogleFonts.almarai(
                                        height: 1,
                                        textStyle: TextStyle(
                                            color: blueCol,
                                            height: 1.5, // Increase line spacing

                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      )),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -4,
              right: -4,
              child: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.redAccent,
                splashRadius: 1,
                onPressed: () async {
                  bool accept = await showNoHeader(txt: 'are you sure you want to remove this notification ?',btnOkText: 'Remove',);
                  if(!accept) return;

                  layCtr.notifs.removeAt(i);
                  layCtr.update();
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
deviceeCard(DeviceModel devicee,i, {bool tappable = true, bool canDelete = true, Function()? btnOnPress}) {
  double bottomProdName = 9;
  double bottomProdBuy = 6;

  return GestureDetector(
    onTap: () {
      layCtr.selectDevice(devicee);
   layCtr. jumpToLoc(devicee.latitude, devicee.longitude);

    },
    child: Container(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: productBorderCol, width: 1.5), borderRadius: BorderRadius.circular(13)),
        color: productCardColor,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      /// ICON
                      Icon(
                        Icons.sensors,
                        color: Colors.blue,
                        size: 70,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: bottomProdName, top: 5),
                            child: Text('${devicee.device.name}', style: TextStyle(
                                color: normalTextCol,
                                fontWeight: FontWeight.w400,
                                fontSize: 17
                            )),
                          ),

                          /// Address
                          Padding(
                            padding: EdgeInsets.only(bottom: bottomProdBuy),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Address:',
                                    style: GoogleFonts.almarai(
                                      height: 1,
                                      textStyle: TextStyle(color: transparentTextCol, fontSize: 13, fontWeight: FontWeight.w500),
                                    )),
                                TextSpan(
                                    text: '  ${devicee.device.adresse}',
                                    style: GoogleFonts.almarai(
                                      height: 1,
                                      textStyle: TextStyle(
                                          color: blueCol,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    )),
                              ]),
                            ),
                          ),
                          /// Region
                          Padding(
                            padding: EdgeInsets.only(bottom: bottomProdBuy),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(children: [
                                TextSpan(
                                    text: 'Region:',
                                    style: GoogleFonts.almarai(
                                      height: 1,
                                      textStyle: TextStyle(color: transparentTextCol, fontSize: 13, fontWeight: FontWeight.w500),
                                    )),
                                TextSpan(
                                    text: '  ${devicee.device.region}',
                                    style: GoogleFonts.almarai(
                                      height: 1,
                                      textStyle: TextStyle(
                                          color: blueCol,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    )),
                              ]),
                            ),
                          ),
                          /// Description
                          Padding(
                            padding: EdgeInsets.only(bottom: bottomProdBuy),
                            child: SizedBox(
                              width: 60.w,
                              child: RichText(
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.visible, // Set overflow to visible

                                text: TextSpan(children: [
                                  TextSpan(
                                      text: 'Description:',
                                      style: GoogleFonts.almarai(
                                        height: 1,
                                        textStyle: TextStyle(color: transparentTextCol, fontSize: 13, fontWeight: FontWeight.w500),
                                      )),
                                  TextSpan(
                                      text: '  ${devicee.device.description}',
                                      style: GoogleFonts.almarai(
                                        height: 1,
                                        textStyle: TextStyle(
                                            color: blueCol,
                                            height: 1.5, // Increase line spacing

                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      )),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -4,
              right: -4,
              child: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.redAccent,
                splashRadius: 1,
                onPressed: () async {
                  bool accept = await showNoHeader(txt: 'are you sure you want to remove this device ?',btnOkText: 'Remove',);
                  if(!accept) return;

                  layCtr.devices.removeAt(i);
                  layCtr.update();
                },
              ),
            ),
            Positioned(
              bottom: 30,
              right:  25, //english
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      layCtr.selectDevice(devicee);
                      layCtr.jumpTochart();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.2),
                      radius: 18,
                      child: Icon(
                        color:  Colors.blue,
                        Icons.show_chart,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    ),
  );
}

// deviceeCard0(DeviceModel devicee,i, {bool tappable = true, bool canDelete = true, Function()? btnOnPress}) {
//   double bottomProdName = 9;
//   double bottomProdBuy = 6;
//
//   return GestureDetector(
//     onTap: () {
//    layCtr. jumpToLoc(devicee.latitude, devicee.longitude);
//
//     },
//     child: Container(
//       child: Card(
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//             side: BorderSide(color: productBorderCol, width: 1.5), borderRadius: BorderRadius.circular(13)),
//         color: productCardColor,
//         child:  Container(
//             padding: const EdgeInsets.all(10),
//             child: ExpansionTileCard(
//               key: cardB,
//               expandedTextColor: Colors.red,
//
//               leading:  Icon(
//                 Icons.sensors,
//                 color: Colors.blueAccent[700],
//                 size: 40,
//               ),
//               title: const Text('Tap me!'),
//               subtitle: const Text('I expand, too!'),
//               children: <Widget>[
//                 const Divider(
//                   thickness: 1.0,
//                   height: 1.0,
//                   color: transparentTextCol,
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0,
//                       vertical: 8.0,
//                     ),
//                     child: Text(
//                       """Hi there, I'm a drop-in replacement for Flutter's ExpansionTile.
//
// Use me any time you think your app could benefit from being just a bit more Material.
//
// These buttons control the card above!""",
//                       style: TextStyle(color:normalTextCol),
//                     ),
//                   ),
//                 ),
//                 ButtonBar(
//                   alignment: MainAxisAlignment.spaceAround,
//                   buttonHeight: 52.0,
//                   buttonMinWidth: 90.0,
//                   children: <Widget>[
//                     TextButton(
//                       style: flatButtonStyle,
//                       onPressed: () {
//                         cardA.currentState?.expand();
//                       },
//                       child: const Column(
//                         children: <Widget>[
//                           Icon(Icons.arrow_downward),
//                           Padding(
//                             padding: EdgeInsets.symmetric(vertical: 2.0),
//                           ),
//                           Text('Open'),
//                         ],
//                       ),
//                     ),
//                     TextButton(
//                       style: flatButtonStyle,
//                       onPressed: () {
//                         cardA.currentState?.collapse();
//                       },
//                       child: const Column(
//                         children: <Widget>[
//                           Icon(Icons.arrow_upward),
//                           Padding(
//                             padding: EdgeInsets.symmetric(vertical: 2.0),
//                           ),
//                           Text('Close'),
//                         ],
//                       ),
//                     ),
//                     TextButton(
//                       style: flatButtonStyle,
//                       onPressed: () {
//                         cardA.currentState?.toggleExpansion();
//                       },
//                       child: const Column(
//                         children: <Widget>[
//                           Icon(Icons.swap_vert),
//                           Padding(
//                             padding: EdgeInsets.symmetric(vertical: 2.0),
//                           ),
//                           Text('Toggle'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             )
//         ),,
//       ),
//     ),
//   );
// }

/// ****** DEFAULT WIDGETS **************///////////////////////////////////////////////


Widget customFAB({String? text, IconData? icon, VoidCallback? onPressed, String? heroTag}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 00.0, vertical: 00),
    child: Container(
      // height: 40.0,
      // width: 130.0,
      //constraints: BoxConstraints(minWidth: 56.0),

      child: FittedBox(
        child: FloatingActionButton.extended(
          onPressed: onPressed,

          heroTag: heroTag,
          //backgroundColor: yellowColHex,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon ?? Icons.add),
              SizedBox(width: 8),
              Text(
                text ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget customTextField(
    {Color? color,
      bool enabled = true,
      void Function(String)? onChanged,
      TextInputType? textInputType,
      String? hintText,
      String? labelText,
      TextEditingController? controller,
      String? Function(String?)? validator,
      bool obscure = false,
      bool isPwd = false,
      bool isDense = false,
      List<TextInputFormatter>? inputFormatters,
      Function()? onSuffClick,
      IconData? icon}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: Container(
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        keyboardType: textInputType,
        textInputAction: TextInputAction.done,
        obscureText: obscure,
        inputFormatters: inputFormatters,


        ///pwd


        enabled: enabled,
        style: TextStyle(color: dialogFieldWriteCol, fontSize: 14.5),
        validator: validator,
        decoration: InputDecoration(
          //enabled: false,

          isDense: isDense,
          alignLabelWithHint: false,
          filled: false,
          isCollapsed: false,

          focusColor: color ?? Colors.white,
          fillColor: color ?? Colors.white,
          hoverColor: color ?? Colors.white,
          contentPadding: const EdgeInsets.only(bottom: 0, right: 20, top: 0),
          suffixIconConstraints: BoxConstraints(minWidth: 50),
          prefixIconConstraints: BoxConstraints(minWidth: 50),
          prefixIcon: Icon(
            icon,
            color: dialogFieldIconCol,
            size: 22,
          ),
          suffixIcon: isPwd
              ? IconButton(

            ///pwd

              icon: Icon(
                !obscure ? Icons.visibility : Icons.visibility_off,
                color: dialogFieldIconCol,
              ),
              onPressed: onSuffClick)
              : null,
          border: InputBorder.none,
          disabledBorder: InputBorder.none,

          hintText: hintText ?? '',
          hintStyle: TextStyle(color: dialogFieldHintCol, fontSize: 14.5),

          labelText: labelText!,
          labelStyle: TextStyle(color: dialogFieldLabelCol, fontSize: 14.5),

          errorStyle: TextStyle(color: dialogFieldErrorUnfocusBorderCol.withOpacity(.9), fontSize: 12, letterSpacing: 1),

          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide(color: dialogFieldEnableBorderCol)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide(color: dialogFieldDisableBorderCol)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide(color: dialogFieldErrorUnfocusBorderCol)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100), borderSide: BorderSide(color: dialogFieldErrorFocusBorderCol)),
        ),
      ),
    ),
  );
}

String getDayString(String time) {
  DateTime parsedDateTime = dateFormatHM.parse(time);
  String day = parsedDateTime.day.toString();

  return day;
}



getYearString(String time) {
  return dateFormatHM.parse(time).year.toString();
}

elementNotFound(text,{double? top}){
  return Padding(
    padding: EdgeInsets.only(top: top?? 35.h),
    child: Text(text, textAlign: TextAlign.center, style: GoogleFonts.indieFlower(
      textStyle:  TextStyle(
          fontSize: 23  ,
          color: elementNotFoundColor,
          fontWeight: FontWeight.w700
      ),
    )),
  );
}

Widget monthSquare(String date,{bool withSec = false}) {
  DateTime dateTime;
  if(withSec){
    dateTime = dateFormatHMS.parse(date);//withSec = true
  }else{
    dateTime = dateFormatHM.parse(date);//withSec = false
  }

  String day = dateTime.day.toString();

  String weekDay3Name = DateFormat('EEE').format(dateTime);
  String time = DateFormat("HH:mm").format(dateTime);

  return Container(
    // color: Colors.greenAccent,

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // week
          Text(
            weekDay3Name,
            maxLines: 1,
            style: TextStyle(
              fontSize: 13,
              height: 1,
              color: squareDateCol,
            ),
          ),
          SizedBox(height: 2),
          // month number
          Container(
            //color:Colors.redAccent,
            width: 40,
            height: 40,
            child: Text(
              day,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                height: 0,
                fontWeight: FontWeight.bold,
                color: squareDateCol,
              ),
            ),
          ),
          SizedBox(height: 2),

          // time
          Text(
            time,//15:06
            maxLines: 1,
            style: TextStyle(
              fontSize: 13,
              height: 0,
              color: squareDateCol,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget indexSquare(String time, String index, verified) {
  String day = dateFormatHM.parse(time).day.toString();
  String timeString = DateFormat("HH:mm").format(dateFormatHM.parse(time));

  return Container(
    width: 70,
    height: 90,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      //color: Colors.white,
      // border: Border.all(
      //   color: Colors.white,
      //   width: 2,
      // ),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 7.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Num°',
            maxLines: 1,
            style: TextStyle(
              fontSize: 13,
              height: 0.5,
              color: Colors.white,
            ),
          ),
          Text(
            index,
            maxLines: 1,
            style: TextStyle(
              fontSize: 26,
              height: 1.3,
              fontWeight: FontWeight.bold,
              color: verified ? Colors.greenAccent : Color(0xFFFFF66B).withOpacity(.8),
            ),
          ),
          Text(
            timeString,
            maxLines: 1,
            style: TextStyle(
              fontSize: 13,
              height: 1,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget backGroundTemplate({Widget? child}) {
  return Container(
    //alignment: Alignment.topCenter,
    width: 100.w,
    height: 100.h,
    decoration: const BoxDecoration(
      // image: DecorationImage(
      //   //image: AssetImage("assets/images/bg.png"),
      //   image: NetworkImage("https://img.freepik.com/premium-vector/general-view-factorys-industrial-premises-from-inside_565173-3.jpg"),
      //   fit: BoxFit.cover,
      // ),
    ),
    child: child,
  );
}

Widget customButton(
    {bool reversed = false,
      bool disabled = false,
      Function()? btnOnPress,
      Widget? icon,
      String textBtn = 'button',
      double btnWidth = 200,
      Color? fillCol,
      Color? borderCol}) {
  List<Widget> buttonItems = [
    icon!,

    SizedBox(width: 10),
    Text(
      textBtn,
      style: TextStyle(
        color: btnTextCol,
        fontSize: 16,
      ),
    ),
    //Icon(Icons.send_rounded,  color: Colors.white,),
  ];

  return SizedBox(
    width: btnWidth,
    child: ElevatedButton(
      onPressed: btnOnPress!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: reversed ? buttonItems.reversed.toList() : buttonItems,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: !disabled ? fillCol ?? btnFillCol : disabledBtnFillCol,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(
          color: !disabled ? borderCol ?? btnBorderCol : disabledBtnBorderCol,
          width: 2,
        ),
      ),
    ),
  );
}

Widget prop(title, prop, {Color color = Colors.white, double spaceBetween = 15.0, String extraTxt = ''}) {
  return Padding(
    padding: EdgeInsets.only(bottom: spaceBetween),
    child: Row(
      children: [
        Text(
          '$title',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19, color: color),
        ),
        SizedBox(width: 8),
        Text(
          '$prop',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.white70),
        ),
        SizedBox(width: 5),
        Text(
          '$extraTxt',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 11, color: Colors.white),
        ),
      ],
    ),
  );
}

Widget animatedText(String txt, double textSize, int speed) {
  return SizedBox(
    height: 40,
    child: AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(txt,
            textStyle: GoogleFonts.indieFlower(
              textStyle: TextStyle(fontSize: textSize, color: animatedTextCol, fontWeight: FontWeight.w800),
            ),
            speed: Duration(
              milliseconds: speed,
            )),
      ],
      onTap: () {
        //debugPrint("Welcome back!");
      },
      isRepeatingAnimation: true,
      totalRepeatCount: 40,
    ),
  );
}
