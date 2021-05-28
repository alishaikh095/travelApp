import 'package:flutter/material.dart';

class BusinessHours {
  final dayName;
  final openTime;
  final closeTime;

  BusinessHours({this.dayName, this.openTime, this.closeTime});
}

class Listing {
  final int id;
  final String title;
  final String description;
  final String phoneNumber;
  final String category;
  final String imgUrl;
  final List<BusinessHours> busHours;
  final String address;
  Listing({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.phoneNumber,
    @required this.category,
    @required this.imgUrl,
    this.busHours,
    @required this.address,
  });
}
