import 'dart:io';
import "package:async/async.dart";
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import '../models/package.dart';
import 'package:http/http.dart' as http;

class EventProvider with ChangeNotifier {
  final Map<String, Object> userData;
  EventProvider(this.userData);

  Future<void> addEvent(Package package, File eventImage) async {
    var stream =
        // ignore: deprecated_member_use
        http.ByteStream(DelegatingStream.typed(eventImage.openRead()));
    var length = await eventImage.length();
    var url = Uri.parse(
        "https://www.emraancheema.com/app/wp-json/listing_add_pkg/v1");

    // try {
    var request = http.MultipartRequest("POST", url);

    var multipartFile = http.MultipartFile("event_img", stream, length,
        filename: basename(eventImage.path) + ".jpg");
    request.files.add(multipartFile);
    if (this.userData != null) {
      request.fields['eUID'] = this.userData['ID'];
    } else {
      request.fields['eUID'] = 'user';
    }
    request.fields['eLID'] = package.id.toString();
    request.fields['eTitle'] = package.title;
    request.fields['eLoc'] = package.pkgLoc;
    request.fields['userId'] = this.userData['ID'];
    request.fields['eDate'] =
        DateFormat('MM/dd/yyyy').format(package.startDate);
    request.fields['eDateE'] = DateFormat('MM/dd/yyyy').format(package.endDate);

    request.fields['eTime'] = package.startTime;
    request.fields['eTimeE'] = package.endTime;
    request.fields['eDesc'] = package.pkgDesc;
    request.fields['ePrice'] = package.price;
    try {
      var respond = await request.send();
      final respStr = await respond.stream.bytesToString();
      print(respStr);
    } catch (e) {
      print(e);
    }
  }
}
