import 'package:flutter/material.dart';
import 'package:ghoom_pakistan/providers/listing_provider.dart';
import 'package:provider/provider.dart';

class ListingDetailScreen extends StatelessWidget {
  static const routeName = '/listing-detail';
  String replaceString(String catName) {
    return catName.replaceAll('&amp;', '&');
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final deviceConstraint = MediaQuery.of(context).size;
    // print(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Euro Collison'),
      ),
      body: FutureBuilder(
        future: Provider.of<ListingProvider>(context, listen: false)
            .getListingDetail(id),
        builder: (ctx, dataSnapshot) => dataSnapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(children: [
                    Image.network(
                      dataSnapshot.data.imgUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.black26,
                      height: 250,
                    ),
                    Positioned(
                        bottom: 30.0,
                        left: 10.0,
                        child: Text(
                          dataSnapshot.data.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )),
                    Positioned(
                        left: 10.0,
                        bottom: 10.0,
                        child: Text(
                          replaceString(dataSnapshot.data.category),
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
                  ]),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Business Hours',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: dataSnapshot.data.busHours.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            dataSnapshot.data.busHours[index].dayName,
                            style: TextStyle(fontSize: 11),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
