import 'package:flutter/foundation.dart';

class Exclusive with ChangeNotifier {
  final int id;
  final String title;
  final String description;
  final String phoneNumber;
  final String city;
  final String fullAddress;
  final String imgUrl;
  final String category;
  final String catName;
  final String emailAdress;
  final String website;
  bool isFavorite;

  Exclusive(
      {this.id,
      this.title,
      this.imgUrl,
      this.description,
      this.phoneNumber,
      this.city,
      this.fullAddress,
      this.website,
      this.catName,
      this.emailAdress,
      this.category,
      this.isFavorite = false});

  void toggleFavStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
