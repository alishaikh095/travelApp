import 'package:flutter/material.dart';
import 'package:ghoom_pakistan/providers/event_provider.dart';
import './screens/add_package_screen.dart';
import './screens/listing_detail.dart';
import './providers/listing_provider.dart';
import './providers/auth.dart';
import './screens/auth_screen.dart.dart';
import './providers/location_provider.dart';
import './providers/exclusive_provider.dart';
import './providers/category_provider.dart';
import 'package:provider/provider.dart';
import './screens/add_listing_scree.dart';
import './screens/home_screen.dart';
import './screens/splash_screen.dart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider.value(
            value: Categories(),
          ),
          ChangeNotifierProxyProvider<Auth, ExclusiveProvider>(
              create: (BuildContext context) => ExclusiveProvider(
                  Provider.of<Auth>(context, listen: false).user),
              update: (ctx, auth, prevUser) => ExclusiveProvider(
                  prevUser.userData == null ? null : prevUser.userData)),
          ChangeNotifierProvider.value(
            value: LocationProvider(),
          ),
          ChangeNotifierProvider.value(
            value: ListingProvider(),
          ),
          ChangeNotifierProxyProvider<Auth, EventProvider>(
              create: (BuildContext context) =>
                  EventProvider(Provider.of<Auth>(context, listen: false).user),
              update: (ctx, auth, prevUser) => EventProvider(
                  prevUser.userData == null ? null : prevUser.userData))
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ghoom Pakistan',
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              accentColor: Colors.amber,
              fontFamily: 'Poppins',
              textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText1: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  bodyText2: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  headline6: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            home: auth.isLogin
                ? HomeScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              AddListingScreen.routeName: (_) => AddListingScreen(),
              ListingDetailScreen.routeName: (_) => ListingDetailScreen(),
              AddPackageScreen.routeName: (_) => AddPackageScreen(),
              AuthScreen.routeName: (_) => AuthScreen()
            },
          ),
        ));
  }
}
