import 'package:flutter/material.dart';
import '../widgets/location_slider.dart';
import '../providers/location_provider.dart';
import '../providers/category_provider.dart';
import '../providers/exclusive_provider.dart';
import '../widgets/categorySlider.dart';
import '../widgets/excl_slider.dart';
import 'package:provider/provider.dart';
import '../widgets/appDrawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isinit = true;
  Widget searchBarHome() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(143, 137, 198, 0.2),
              spreadRadius: 10,
              blurRadius: 50,
              offset: Offset(0, 5),
            )
          ],
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: TextField(
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                labelText: 'Ex: Swat, hotels, packages',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    if (_isinit) {
      Provider.of<ExclusiveProvider>(context).fetchExlusive();
      Provider.of<Categories>(context).fetchCategory();
      Provider.of<LocationProvider>(context).fetchHomeLoc();
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Home Screen'),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Browse Trips',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Explore Pakistan',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            searchBarHome(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            CategorySlider(),
            Text(
              'Exclusive',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Text(
              'Popular Companies in our directory',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            ExclusiveSlider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              'Happenig City',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Text(
              'Cities you must explore this summer',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            LocationSlider(),
          ],
        ),
      ),
    );
  }
}
