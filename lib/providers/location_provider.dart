import 'package:flutter/material.dart';
import 'package:ghoom_pakistan/models/locations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationProvider with ChangeNotifier {
  List<Location> _locations = [];

  List<Location> get locItems {
    return [..._locations];
  }

  Future<void> fetchHomeLoc() async {
    final url = 'https://www.emraancheema.com/app/wp-json/get_all_listings/v1';

    try {
      final resp = await http.get(Uri.parse(url));
      final extractedData = json.decode(resp.body) as List<dynamic>;

      final List<Location> locArray = [];

      extractedData.forEach((loc) {
        locArray.add(
          Location(
              id: int.parse(loc['id']),
              name: loc['name'],
              totalListings: loc['NumbrOfListings'].toString(),
              locationPic: loc['locationPic']),
        );
      });
      _locations = locArray;
      notifyListeners();
    } catch (error) {
      // print(error);
    }
  }
}
