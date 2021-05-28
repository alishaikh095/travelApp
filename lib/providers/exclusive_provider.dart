import 'dart:io';
import "package:async/async.dart";
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import '../models/exlusiveListing.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';

class ExclusiveProvider with ChangeNotifier {
  List<Exclusive> _excList = [];
  final Map<String, Object> userData;

  List<Exclusive> _pubListings = [];

  ExclusiveProvider(this.userData);
  List<Exclusive> get excItems {
    return [..._excList];
  }

  List<Exclusive> get pubItenms {
    return [..._pubListings];
  }

  Exclusive finById(int id) {
    return _excList.firstWhere((exc) => exc.id == id);
  }

  Future<void> fetchExlusive() async {
    const url = 'https://www.emraancheema.com/app/wp-json/get_excl_listings/v1';

    try {
      final exclData = await http.get(Uri.parse(url));
      final extractedData = json.decode(exclData.body) as dynamic;
      final List<Exclusive> loadedExc = [];
      extractedData.forEach((listing) {
        loadedExc.add(Exclusive(
          id: listing['id'],
          title: listing['name'],
          imgUrl: listing['featuredImage'][0],
          description: truncateWithEllipsis(10, listing['content']),
          phoneNumber: listing['listPhone'],
          city: listing['location'][0]['name'],
          fullAddress: listing['address'],
          website: listing['plan'],
          catName: listing['category'][0]['name'],
        ));
      });

      _excList = loadedExc;
      notifyListeners();
    } catch (error) {
      // print(error);
    }
  }

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }

  Future<String> addListing(Exclusive exclusivelist, File featuredImg) async {
    var respStr;
    var stream =
        // ignore: deprecated_member_use
        http.ByteStream(DelegatingStream.typed(featuredImg.openRead()));
    var length = await featuredImg.length();
    var url =
        Uri.parse("https://www.emraancheema.com/app/wp-json/submit_listing/v1");

    // try {
    var request = http.MultipartRequest("POST", url);

    var multipartFile = http.MultipartFile("lp-featuredimage", stream, length,
        filename: basename(featuredImg.path),
        contentType: MediaType('image', 'jpeg'));
    request.files.add(multipartFile);
    print(multipartFile.filename);
    if (this.userData != null) {
      request.fields['user_id'] = this.userData['ID'];
    } else {
      request.fields['user_id'] = 'user';
    }
    request.fields['post_title'] = exclusivelist.title;
    request.fields['post_content'] = exclusivelist.description;
    request.fields['category'] = exclusivelist.category;
    request.fields['phone'] = exclusivelist.phoneNumber;
    request.fields['location'] = exclusivelist.city;
    request.fields['gAddress'] = exclusivelist.fullAddress;
    request.fields['website'] = exclusivelist.website;
    if (this.userData == null) {
      request.fields['email'] = exclusivelist.emailAdress;
    }
    request.fields['plan_id'] = '114';
    print(request.fields);
    try {
      var respond = await request.send();
      respStr = await respond.stream.bytesToString();
      print(json.decode(respStr)["status"]);
    } catch (error) {
      print(error);
      throw error;
    }
    return respStr;
  }

  Future<List<Exclusive>> fetchPublishedListings(String query) async {
    final List<Exclusive> loadedPub = [];
    const url =
        'https://www.emraancheema.com/app/wp-json/get_dashboard_publish_listings/v1/data/1/-1/paged';

    try {
      final exclData = await http.get(Uri.parse(url));

      final extractedData = json.decode(exclData.body) as dynamic;
      var responseData;
      responseData = extractedData['listings'];

      responseData.forEach((listing) {
        var img, catName, location;
        if (listing['featuredImage'] != false) {
          img = listing['featuredImage'][0];
        }
        if (listing['location'] != false) {
          location = listing['location'][0]['name'];
        }
        if (listing['category'] != false) {
          catName = listing['category'][0]['name'];
        }
        loadedPub.add(Exclusive(
          id: listing['id'],
          title: listing['name'],
          imgUrl: img,
          description: truncateWithEllipsis(10, listing['content']),
          phoneNumber: listing['listPhone'],
          city: location,
          fullAddress: listing['address'],
          website: listing['plan'],
          catName: catName,
        ));
      });
      notifyListeners();
    } catch (error) {
      print(error);
    }
    return loadedPub.where((element) {
      final nameLower = element.title.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }
}
