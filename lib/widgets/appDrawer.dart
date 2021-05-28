import 'package:flutter/material.dart';
import '../screens/auth_screen.dart.dart';
import '../screens/add_package_screen.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../screens/add_listing_scree.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('User'),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Listing'),
            onTap: () {
              Navigator.of(context).pushNamed(AddListingScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Package'),
            onTap: () {
              Navigator.of(context).pushNamed(AddPackageScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
