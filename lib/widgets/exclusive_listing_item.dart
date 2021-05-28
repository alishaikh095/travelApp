import 'package:flutter/material.dart';
import '../screens/listing_detail.dart';

class ExclusiveListingItem extends StatelessWidget {
  final int id;
  final String imgUrl;
  final String title;
  final String descr;
  final String city;

  ExclusiveListingItem(this.id, this.imgUrl, this.title, this.descr, this.city);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imgUrl,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black26,
            ),
          ),
          Positioned(
            top: 10,
            left: 15,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ListingDetailScreen.routeName, arguments: id);
              },
              child: Text(
                title,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Positioned(
            left: 15,
            bottom: 50,
            child: Text(
              descr,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          Positioned(
            left: 15,
            bottom: 10,
            child: Row(
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 15,
                ),
                Container(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    'Call Now',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(width: 1.0, color: Colors.white))),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Text(
                    city,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 10,
              right: 15,
              child: Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 15,
              ))
        ],
      ),
    );
  }
}
