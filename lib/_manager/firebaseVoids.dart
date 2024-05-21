import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;
import 'bindings.dart';
import 'myVoids.dart';
import 'dart:io';

/// add DOCUMENT to fireStore
//  if specificID!='' ID will be added to 'prefs'
Future<void> addDocument(
    {required fieldsMap,
    required CollectionReference coll,
    bool addIDField = true,
    String specificID = '',
    bool addRealTime = false,
    String docPathRealtime = '',
    Map<String, dynamic>? realtimeMap}) async {
  if (specificID != '') {
    coll.doc(specificID).set(fieldsMap).then((value) async {
      print("## DOC ADDED TO <${coll.path}>");

      //add id to doc
      if (addIDField) {
        //set id
        coll.doc(specificID).update(
          {
            ///this
            'id': specificID,
          },
          //SetOptions(merge: true),
        );
      }
    }).catchError((error) {
      print("## Failed to add doc to <${coll.path}>: $error");
    });
  } else {
    coll.add(fieldsMap).then((value) async {
      print("## DOC ADDED TO <${coll.path}>");

      //add id to doc
      if (addIDField) {
        String docID = value.id;
        //set id
        coll.doc(docID).update(
          {
            ///this
            'id': docID,
          },
          //SetOptions(merge: true),
        );
      }
    }).catchError((error) {
      print("## Failed to add doc to <${coll.path}>: $error");
      showSnack(snapshotErrorMsg, color: Colors.black54);
      throw Exception('## Exception ');
    });
  }
}
