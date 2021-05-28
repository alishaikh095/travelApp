import 'package:flutter/material.dart';
import '../models/listing.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListingProvider with ChangeNotifier {
  Future<Listing> getListingDetail(int id) async {
    final url =
        'https://www.emraancheema.com/app/wp-json/get_listing/v1/data/$id';
    final listDetail = await http.get(Uri.parse(url));
    final extractedData = json.decode(listDetail.body);
    final List<BusinessHours> busTimings = [];
    final bushours = extractedData['business_hours'] as Map<String, dynamic>;
    bushours.forEach((dayname, timings) {
      busTimings.add(BusinessHours(
          dayName: dayname,
          openTime: timings['open'],
          closeTime: timings['close']));
    });
    notifyListeners();
    return Listing(
        id: extractedData['listing']['ID'],
        title: extractedData['listing']['post_title'],
        description: extractedData['listing']['post_content'],
        phoneNumber: extractedData['Phone'],
        category: extractedData['category'],
        imgUrl: extractedData['featured_Image'],
        busHours: busTimings,
        address: extractedData['gAddress']);
  }
}
