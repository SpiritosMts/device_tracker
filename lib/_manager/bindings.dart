

import 'package:get/get.dart';

import 'auth/authCtr.dart';
import 'generalLayout/generalLayoutCtr.dart';


AuthController authCtr = AuthController.instance;

LayoutCtr get layCtr => Get.find<LayoutCtr>();




///PatientsListCtr get patListCtr => Get.find<PatientsListCtr>(); //default


class GetxBinding implements Bindings {
  @override
  void dependencies() {
    //TODO

    Get.put<AuthController>(AuthController());
    Get.lazyPut<LayoutCtr>(() => LayoutCtr(),fenix: true);



  }
}