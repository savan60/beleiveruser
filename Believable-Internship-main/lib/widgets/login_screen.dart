import 'package:believableuser/screens/product_detail_page.dart';
import 'package:believableuser/screens/products_list_page.dart';
import 'package:believableuser/widgets/product_list_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(AuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential?.user != null) {
        Navigator.of(context).pushReplacementNamed(ProductsListPage.routename);
      }
    } on AuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  getMobileFormWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 60),
          child: Text(
            "Register in to get started",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 15.0, bottom: 30),
          child: Text(
            "Experience the all new App!",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        TextFormField(
          controller: phoneController,
          validator: (value) {
            if (value.isEmpty || value.length != 10) {
              return 'Mobile Number must be of 10 digits';
            }
            return null;
          },
          decoration: InputDecoration(
            prefixIcon: Image.asset(
              "assets/images/phone-24px.png",
            ),
            labelText: 'Mobile Number',
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: 500,
          height: 50,
          child: FlatButton(
            onPressed: () async {
              setState(() {
                showLoading = true;
              });

              await _auth.verifyPhoneNumber(
                phoneNumber: phoneController.text,
                verificationCompleted: (phoneAuthCredential) async {
                  setState(() {
                    showLoading = false;
                  });
                },
                verificationFailed: (verificationFailed) async {
                  setState(() {
                    showLoading = false;
                  });
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text(verificationFailed.message)));
                },
                codeSent: (verificationId, [resendingToken]) async {
                  setState(() {
                    showLoading = false;
                    currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                    this.verificationId = verificationId;
                  });
                },
                codeAutoRetrievalTimeout: (verificationId) async {},
                timeout: Duration(
                  seconds: 60,
                ),
              );
            },
            child: Text("SEND"),
            color: Colors.orange,
            textColor: Colors.white,
          ),
        ),
        Spacer(),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 60),
          child: Text(
            "Register in to get started",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 15.0, bottom: 30),
          child: Text(
            "Experience the all new App!",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        TextFormField(
          controller: otpController,
          validator: (value) {
            if (value.isEmpty || value.length != 6) {
              return 'OTP Number must be of 6 digits';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: 'Enter OTP',
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: 500,
          height: 50,
          child: FlatButton(
            onPressed: () async {
              AuthCredential phoneAuthCredential =
                  PhoneAuthProvider.getCredential(
                      verificationId: verificationId,
                      smsCode: otpController.text);

              signInWithPhoneAuthCredential(phoneAuthCredential);
            },
            child: Text("VERIFY"),
            color: Colors.blue,
            textColor: Colors.white,
          ),
        ),
        Spacer(),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(16),
        ));
  }
}
