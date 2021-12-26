import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

Future readExcelFile(String fileName)async{

  ByteData data = await rootBundle.load("assets/$fileName");
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);
  int j=0;
  Map<int,  List<String> > map = {};
  for (var table in excel.tables.keys) {
    for (dynamic row in excel.tables[table]!.rows) {
      map[++j] = row ;
    }
  }
  return map;
}

Future<void> logOut({
  required context,
}) async
{
  await FirebaseAuth.instance.signOut();
}

Future<List<String>> readTextFile({required String txtFileName}) async {

  String allFile =  await rootBundle.loadString('assets/$txtFileName');

  return allFile.split('\n');
}

void showStylishDialog(context){
  StylishDialog(
    context: context,
    alertType: StylishDialogType.INFO,
    titleText: 'Authentication',
    contentText: 'Approve permission to complete authentication',
    confirmButton: MaterialButton(
      color: Colors.deepOrange,
      onPressed: () {
        launchURL('https://www.themoviedb.org/authenticate/$token');
        Navigator.of(context).pop();
      },
      child: (
          const Text(
            'OK',
            style: TextStyle(color: Colors.white),
          )),
    ),
    cancelButton: MaterialButton(
      color: Colors.grey,
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: (
          Text(
            'cancel',
            style: TextStyle(color: Colors.white),
          )),
    ),
  ).show();
}


Future<bool> checkConnectivity ()async{
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network.
  }
  else if (connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a wifi network.
  }
  else if(connectivityResult == ConnectivityResult.none){
    return false;
  }
  return true;
}


void launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch : $url';
  }
}




