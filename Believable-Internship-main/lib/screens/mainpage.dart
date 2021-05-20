import 'package:believableuser/screens/email_auth.dart';
import 'package:believableuser/screens/initial_file.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  static final String routename = "/main-page";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                RaisedButton(
                  child: Text('Login with Mobile'),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(InitializerWidget.routename);
                  },
                ),
                RaisedButton(
                  child: Text('Login with Email'),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      AuthScreen.routename,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
