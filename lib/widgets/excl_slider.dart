import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../providers/exclusive_provider.dart';
import '../widgets/exclusive_listing_item.dart';
import 'package:provider/provider.dart';

class ExclusiveSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listData = Provider.of<ExclusiveProvider>(context);
    return CarouselSlider(
      options: CarouselOptions(disableCenter: false, viewportFraction: 1),
      items: listData.excItems
          .map((item) => ChangeNotifierProvider.value(
              value: item,
              child: ExclusiveListingItem(item.id, item.imgUrl, item.title,
                  item.description, item.city)))
          .toList(),
    );
  }
}
