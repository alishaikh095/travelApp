import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../widgets/location_item.dart';
import '../providers/location_provider.dart';
import 'package:provider/provider.dart';

class LocationSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locData = Provider.of<LocationProvider>(context);
    return CarouselSlider(
      items: locData.locItems
          .map((locItem) => LocationItem(
              locItem.name, locItem.locationPic, locItem.totalListings))
          .toList(),
      options: CarouselOptions(
        disableCenter: true,
        enlargeCenterPage: false,
        height: MediaQuery.of(context).size.height * 0.2,
        viewportFraction: 0.3,
      ),
    );
  }
}
