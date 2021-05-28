import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../widgets/category_item.dart';
import '../providers/category_provider.dart';
import 'package:provider/provider.dart';

class CategorySlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final catg = Provider.of<Categories>(context);

    return CarouselSlider(
      items: catg.catItems
          .asMap()
          .entries
          .map((catItem) =>
              CategoryItem(catItem.value.id, catItem.value.title, catItem.key))
          .toList(),
      options: CarouselOptions(
          disableCenter: true,
          viewportFraction: 0.2,
          height: MediaQuery.of(context).size.height * 0.15),
    );
  }
}
