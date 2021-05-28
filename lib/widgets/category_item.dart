import 'package:flutter/material.dart';
import '../providers/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final int id;
  final String title;
  final int idx;
  CategoryItem(this.id, this.title, this.idx);

  String replaceImgStart(String imgUrl) {
    return imgUrl.replaceAll('http', 'https');
  }

  @override
  Widget build(BuildContext context) {
    final catImgProvdr = Provider.of<Categories>(context).catImgItems;
    return Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(15)),
          child: Image.network(
            replaceImgStart(catImgProvdr[idx]),
            scale: 4,
          ),
        ),
        Container(
          width: 50,
          margin: EdgeInsets.only(top: 8),
          child: Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
            ),
          ),
        )
      ],
    );
  }
}
