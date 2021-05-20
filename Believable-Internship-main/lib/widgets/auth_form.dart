import 'dart:io';
import 'package:believableuser/screens/initial_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    String confirmpassword,
    String phonenumber,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = false;
  String _userEmail = '';
  String _userName = '';
  String _password = '';
  String _confirmpassword = '';
  String _userphonenumber = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _password.trim(),
        _userName.trim(),
        _confirmpassword.trim(),
        _userphonenumber.trim(),
        _isLogin,
        context,
      );
      SnackBar(
        content: Text('Successfully Saved'),
        backgroundColor: Theme.of(context).bottomAppBarColor,
      );
    }
  }

  bool _obpassword = true;
  bool _obpassword1 = true;
  void _togglepassword() {
    setState(() {
      _obpassword = !_obpassword;
    });
  }

  void _togglepasswordnew() {
    setState(() {
      _obpassword1 = !_obpassword1;
    });
  }

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: !_isLogin ? true : false,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Form(
          key: _formKey,
          child: _isLogin
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (!_isLogin)
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            "Register in to get started",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      if (_isLogin)
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            "Log in to get started",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, top: 15.0),
                                        child: Text(
                                          "Experience the all new App!",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      if (!_isLogin)
                                        TextFormField(
                                          key: ValueKey('Name'),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter valid Name!';
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            prefixIcon: Image.asset(
                                              "assets/images/person-24px (1).png",
                                            ),
                                            labelText: 'Name',
                                          ),
                                          onSaved: (value) {
                                            _userName = value;
                                          },
                                        ),
                                      TextFormField(
                                        key: ValueKey('email'),
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              !value.contains('@')) {
                                            return 'Enter valid email address!';
                                          }
                                          return null;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                            "assets/images/email-24px.png",
                                          ),
                                          labelText: 'E-mail ID',
                                        ),
                                        onSaved: (value) {
                                          _userEmail = value;
                                        },
                                      ),
                                      if (!_isLogin)
                                        TextFormField(
                                          key: ValueKey('Mobile Number'),
                                          keyboardType: TextInputType.phone,
                                          validator: (value) {
                                            if (value.isEmpty ||
                                                value.length != 10) {
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
                                          onSaved: (value) {
                                            _userphonenumber = value;
                                          },
                                        ),
                                      TextFormField(
                                        key: ValueKey('password'),
                                        controller: _passwordController,
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 6) {
                                            return 'Password must be atleast 6 characters long!';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                            "assets/images/Icon ionic-ios-lock.png",
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obpassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.black38,
                                            ),
                                            onPressed: _togglepassword,
                                          ),
                                          labelText: 'Password',
                                        ),
                                        obscureText: _obpassword,
                                        onSaved: (value) {
                                          _password = value;
                                        },
                                      ),
                                      if (!_isLogin)
                                        TextFormField(
                                          key: ValueKey('confirm password'),
                                          decoration: InputDecoration(
                                            prefixIcon: Image.asset(
                                              "assets/images/Icon ionic-ios-lock.png",
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obpassword1
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.black38,
                                              ),
                                              onPressed: _togglepasswordnew,
                                            ),
                                            labelText: 'Confirm Password',
                                          ),
                                          obscureText: _obpassword1,
                                          onSaved: (value) {
                                            _confirmpassword = value;
                                          },
                                          validator: (value) {
                                            if (value.isEmpty ||
                                                value.length < 6) {
                                              return 'Confirm Password must be atleast 6 characters long!';
                                            }
                                            if (value !=
                                                _passwordController.text) {
                                              return 'Password did not match!';
                                            }
                                            return null;
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                if (widget.isLoading && !_isLogin)
                                  Center(child: CircularProgressIndicator()),
                                if (!widget.isLoading && !_isLogin)
                                  Container(
                                    padding: EdgeInsets.only(left: 15),
                                    width: 500,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: widget.isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : RaisedButton(
                                            color: Colors.orange,
                                            child: Text(
                                              'REGISTER',
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: _trySubmit,
                                          ),
                                  ),
                                if (!widget.isLoading && !_isLogin)
                                  FlatButton(
                                    textColor: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      setState(() {
                                        _isLogin = !_isLogin;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _isLogin
                                              ? 'Create new account'
                                              : 'Already have an account?',
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          _isLogin ? "" : "Login",
                                          style: TextStyle(
                                            fontSize: 17,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                if (_isLogin)
                                  InkWell(
                                    onTap: () =>
                                        Navigator.of(context).pushNamed(
                                      InitializerWidget.routename,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: 20,
                                      ),
                                      child: Text(
                                        "Use Mobile Number",
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _isLogin
                        ? Center(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              width: 500,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                //borderRadius: BorderRadius.circular(60),
                              ),
                              child: widget.isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : RaisedButton(
                                      color: Colors.orange,
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: _trySubmit,
                                    ),
                            ),
                          )
                        : Container()
                  ],
                )
              : Container(
                  padding: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (!_isLogin)
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "Register in to get started",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    if (_isLogin)
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "Log in to get started",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 15.0),
                                      child: Text(
                                        "Experience the all new App!",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    if (!_isLogin)
                                      TextFormField(
                                        key: ValueKey('Name'),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Enter valid Name!';
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                            "assets/images/person-24px (1).png",
                                          ),
                                          labelText: 'Name',
                                        ),
                                        onSaved: (value) {
                                          _userName = value;
                                        },
                                      ),
                                    TextFormField(
                                      key: ValueKey('email'),
                                      validator: (value) {
                                        if (value.isEmpty ||
                                            !value.contains('@')) {
                                          return 'Enter valid email address!';
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                          "assets/images/email-24px.png",
                                        ),
                                        labelText: 'E-mail ID',
                                      ),
                                      onSaved: (value) {
                                        _userEmail = value;
                                      },
                                    ),
                                    if (!_isLogin)
                                      TextFormField(
                                        key: ValueKey('Mobile Number'),
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length != 10) {
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
                                        onSaved: (value) {
                                          _userphonenumber = value;
                                        },
                                      ),
                                    TextFormField(
                                      key: ValueKey('password'),
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value.isEmpty || value.length < 6) {
                                          return 'Password must be atleast 6 characters long!';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Image.asset(
                                          "assets/images/Icon ionic-ios-lock.png",
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obpassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.black38,
                                          ),
                                          onPressed: _togglepassword,
                                        ),
                                        labelText: 'Password',
                                      ),
                                      obscureText: _obpassword,
                                      onSaved: (value) {
                                        _password = value;
                                      },
                                    ),
                                    if (!_isLogin)
                                      TextFormField(
                                        key: ValueKey('confirm password'),
                                        decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                            "assets/images/Icon ionic-ios-lock.png",
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obpassword1
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.black38,
                                            ),
                                            onPressed: _togglepasswordnew,
                                          ),
                                          labelText: 'Confirm Password',
                                        ),
                                        obscureText: _obpassword1,
                                        onSaved: (value) {
                                          _confirmpassword = value;
                                        },
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 6) {
                                            return 'Confirm Password must be atleast 6 characters long!';
                                          }
                                          if (value !=
                                              _passwordController.text) {
                                            return 'Password did not match!';
                                          }
                                          return null;
                                        },
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              if (widget.isLoading && !_isLogin)
                                Center(child: CircularProgressIndicator()),
                              if (!widget.isLoading && !_isLogin)
                                Container(
                                  padding: EdgeInsets.only(left: 15),
                                  width: 500,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: widget.isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : RaisedButton(
                                          color: Colors.orange,
                                          child: Text(
                                            'REGISTER',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: _trySubmit,
                                        ),
                                ),
                              if (!widget.isLoading && !_isLogin)
                                FlatButton(
                                  textColor: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    setState(() {
                                      _isLogin = !_isLogin;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _isLogin
                                            ? 'Create new account'
                                            : 'Already have an account?',
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      ),
                                      Text(
                                        _isLogin ? "" : "Login",
                                        style: TextStyle(
                                          fontSize: 17,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }
}
