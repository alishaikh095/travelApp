import 'package:flutter/foundation.dart';

class Package with ChangeNotifier {
  final int id;
  final int pkgListing;
  final String title;
  final String pkgLoc;
  final DateTime startDate;
  final DateTime endDate;
  final String pkgDesc;
  final String startTime;
  final String endTime;
  final String price;

  Package(
      {this.id,
      this.title,
      this.pkgListing,
      this.pkgLoc,
      this.startDate,
      this.endDate,
      this.pkgDesc,
      this.price,
      this.startTime,
      this.endTime});
}
