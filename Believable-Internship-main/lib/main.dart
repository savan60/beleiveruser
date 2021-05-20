import 'package:believableuser/screens/email_auth.dart';
import 'package:believableuser/screens/initial_file.dart';
import 'package:believableuser/screens/mainpage.dart';
import 'package:believableuser/screens/product_detail_page.dart';
import 'package:believableuser/screens/productdetailscreen.dart';
import 'package:believableuser/screens/products_list_page.dart';
import 'package:believableuser/screens/spash.dart';
import 'package:believableuser/widgets/product_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return SplasScreen();
          }
          if (userSnapshot.hasData) {
            return ProductsListPage();
          }
          return AuthScreen();
        },
      ),
    
      routes: {
        ProductDetailPage.routename: (ctx) => ProductDetailPage(),
        InitializerWidget.routename: (ctx) => InitializerWidget(),
        AuthScreen.routename: (ctx) => AuthScreen(),
        ProductDetailScreen.routename:(ctx)=>ProductDetailScreen(),
        ProductsListPage.routename:(ctx)=>ProductsListPage()
      },
    );
  }
}
