import 'package:flutter/material.dart';

class LocationItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String totalListings;

  LocationItem(this.name, this.imageUrl, this.totalListings);

  String replaceImgStart(String imgUrl) {
    return imgUrl.replaceAll('http', 'https');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: Image.network(
            replaceImgStart(imageUrl),
            fit: BoxFit.fill,
          ),
          footer: Container(
            height: 35.0,
            child: GridTileBar(
              backgroundColor: Colors.white,
              title: Text(
                name,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 13.0,
                ),
              ),
              subtitle: Text(
                '$totalListings Listings',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 11.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
