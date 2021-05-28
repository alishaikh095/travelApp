import 'package:flutter/foundation.dart';

class Location {
  final int id;
  final String name;
  final String totalListings;
  final String locationPic;

  Location(
      {@required this.id,
      @required this.name,
      @required this.totalListings,
      @required this.locationPic});
}
