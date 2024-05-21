

import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../_models/user.dart';
import 'generalLayout/generalLayout.dart';
import '../main.dart';
import 'auth/login.dart';
import 'auth/register.dart';
import 'bindings.dart';
import 'styles.dart';

ScUser get cUser => authCtr.cUser;
User? get authCurrUser => FirebaseAuth.instance.currentUser;
FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

String appDisplayName = 'BWS';

String snapshotErrorMsg = 'check Connexion'.tr;


CollectionReference usersColl = FirebaseFirestore.instance.collection('users');

DateFormat dateFormatHM = DateFormat('dd-MM-yyyy HH:mm');
DateFormat dateFormatHMS = DateFormat('dd-MM-yyyy HH:mm:ss');

double awesomeDialogWidth =90.sp;


/// ******************************************************

Future<void> goLogin({String email='',String pwd=''}) async{
  await Get.offAll(() => Login(),arguments:  {'email': email,'pwd':pwd});
  authCtr.cUser = ScUser();

}

 goRegister(){
  Get.to(()=>RegisterForm());
}


goHome(){

  Get.offAll(() => GeneralLayout(), transition: Transition.leftToRight, duration: const Duration(milliseconds: 500),);
}













//json
printJson(json) {
  final encoder = JsonEncoder.withIndent('  '); // Set the indentation to 2 spaces
  final prettyPrintedJson = encoder.convert(json);
  print("## ##");
  debugPrint(prettyPrintedJson);
  print("## ##");
}




//dialogs
showAnimDialog(Widget? child, {DialogTransitionType? animationType, int? milliseconds}) {
  showAnimatedDialog(
    context: navigatorKey.currentContext!,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return child ?? Container();
    },
    animationType: animationType ?? DialogTransitionType.slideFromTop,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: milliseconds ?? 500),
  );
}
//aesome dialogs
showVerifyConnexion(){
  AwesomeDialog(
    context: navigatorKey.currentContext!,
    width: awesomeDialogWidth,

    dialogBackgroundColor: dialogBgCol,
    autoDismiss: true,
    dismissOnTouchOutside: true,
    animType: AnimType.scale,
    headerAnimationLoop: false,
    dialogType: DialogType.info,
    btnOkColor: Colors.blueAccent,
    // btnOkColor: yellowColHex

    //showCloseIcon: true,
    padding: EdgeInsets.symmetric(vertical: 15.0),
    titleTextStyle: TextStyle(fontSize: 17.sp, color: dialogAweInfoCol),
    descTextStyle: TextStyle(fontSize: 15.sp,color: dialogDescCol),
    buttonsTextStyle: TextStyle(fontSize: 14.sp),

    title: 'Failed to Connect'.tr,
    desc: 'please verify network'.tr,

    btnOkText: 'Retry'.tr,
    btnOkOnPress: () {},
    onDismissCallback: (type) {
      print('Dialog Dissmiss from callback $type');
    },
    //btnOkIcon: Icons.check_circle,
  ).show();
}
showLoading({required String text}) {
  return AwesomeDialog(
    dialogBackgroundColor: dialogBgCol,
    width: awesomeDialogWidth,
    dismissOnBackKeyPress: true,
    //change later to false
    autoDismiss: true,
    customHeader: Transform.scale(
      scale: .7,
      child: const LoadingIndicator(
        indicatorType: Indicator.ballClipRotate,
        colors: [loadingDialogCol],
        strokeWidth: 10,
      ),
    ),
    titleTextStyle: TextStyle(fontSize: 18.sp, color: dialogTitleCol),
    descTextStyle: TextStyle(fontSize: 16.sp, height: 1.5,color: normalTextCol),



    buttonsTextStyle: TextStyle(fontSize: 15.sp),
    context: navigatorKey.currentContext!,
    dismissOnTouchOutside: false,
    animType: AnimType.scale,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,

    //padding: EdgeInsets.all(8),


    title: text,
    desc: 'Please wait'.tr,
  ).show();
}

Future<bool> showNoHeader({String? txt, String? btnOkText, Color btnOkColor = errorColor, IconData? icon}) async {
  bool shouldDelete = false;

  await AwesomeDialog(
    context: navigatorKey.currentContext!,
    width: awesomeDialogWidth,

    dialogBackgroundColor: dialogBgCol,
    //default :themeData
    autoDismiss: true,
    isDense: true,
    dismissOnTouchOutside: true,
    showCloseIcon: false,
    headerAnimationLoop: false,
    dialogType: DialogType.noHeader,
    animType: AnimType.scale,
    btnCancelIcon: Icons.arrow_back_ios_sharp,
    btnCancelColor: Colors.transparent,
    btnOkIcon: icon ?? Icons.delete,
    //btnOkColor: btnOkColor ?? Colors.red,

    btnCancel: TextButton(
      style: borderBtnStyle(),
      onPressed: () {
        shouldDelete = false;
        Get.back();
      },
      child: Text(
        "Cancel".tr,
        style: TextStyle(color: dialogBtnCancelTextCol),
      ),
    ),
    btnOk: TextButton(
      style: filledBtnStyle(),
      onPressed: () {
        shouldDelete = true;
        Get.back();
      },
      child: Text(
        btnOkText ?? 'delete'.tr,
        style: TextStyle(color: dialogBtnOkTextCol),
      ),
    ),
    titleTextStyle: TextStyle(fontSize: 18.sp, color: dialogTitleCol),
    descTextStyle: TextStyle(fontSize: 16.sp,color: normalTextCol),
    buttonsTextStyle: TextStyle(fontSize: 15.sp),

    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    // texts
    title: 'Verification'.tr,
    desc: txt ?? 'Are you sure you want to delete this image'.tr,
    btnCancelText: 'cancel'.tr,
    btnOkText: btnOkText ?? 'delete'.tr,

    // buttons functions
    btnOkOnPress: () {
      shouldDelete = true;
    },
    btnCancelOnPress: () {
      shouldDelete = false;
    },
  ).show();
  return shouldDelete;
}

//snackbars
showTos(txt, {Color color = Colors.black87, bool withPrint = false}) async {
  Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
  if (withPrint) print(txt);
}
showSnack(txt, {Color? color}) {
  Get.snackbar(
    txt,
    '',
    messageText: Container(),
    colorText: Colors.white,
    backgroundColor: color ?? snackBarNormal,
    snackPosition: SnackPosition.BOTTOM,
  );
}


//network
Future<bool> canConnectToInternet() async {
  bool canConnect = false;
  try {
    final result = await InternetAddress.lookup('google.com');
    /// connected to internet
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //is connected
      canConnect = true;
    }
    /// failed to connect to internet
  } on SocketException catch (_) {
    // not connected

  }
  return canConnect;
}


