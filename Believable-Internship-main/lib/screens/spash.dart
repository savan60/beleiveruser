import 'package:believableuser/size_config.dart';
import 'package:flutter/material.dart';

class SplasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, snapshot) {
      print("here");
      SizeConfig().init(snapshot);
      var maxW = snapshot.maxWidth;
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
            Text("Your digital shop is getting ready!!",style: TextStyle(fontSize: 24),textAlign: TextAlign.center,)
          ],
        ),
      );
    });
  }
}
