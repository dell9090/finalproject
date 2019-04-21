import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';

class ForgetPage extends StatefulWidget {
  static String routeName = '/forgetPage';
  @override
  _ForgetPageState createState() => new _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  final GlobalKey<FormState> _forgetFormKey = GlobalKey<FormState>();
  var _fogetScaffodKey = GlobalKey<ScaffoldState>();
  String _email;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key : _fogetScaffodKey,
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text("Forget Password", style: new TextStyle(color: Colors.white)),
      ),
      body: new Center(
        child: new ListView(
          children: <Widget>[

            SizedBox(height: 48.0),

            Form(
              key: _forgetFormKey,
              child: new TextFormField(
                validator: (input){
                  if(input.isEmpty) {
                    return 'Please enter your email';
                  }
                },
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: new InputDecoration(
                    hintText: 'email',
                    contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)
                    )
                ),
                onSaved: (input) => _email = input,
              ),
            ),

            SizedBox(height: 48.0),

            new Padding(
              padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 120.0),
              child: new Material(
                borderRadius: BorderRadius.circular(32.0),
                shadowColor: Colors.lightBlueAccent.shade100,
                elevation: 5.0,
                child: new MaterialButton(
                  minWidth: 50.0,
                  height: 42.0,
                  onPressed: (){

                    sendEmail();
                  },
                  color: Colors.blue,
                  child: new Text('Comfirm',style: new TextStyle(color: Colors.white),),
                ),
              ),
            ),
            new Center(
              child: new Text("You will receive the reset password email"),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> sendEmail() async {
    if (_forgetFormKey.currentState.validate()) {
      _forgetFormKey.currentState.save();
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        await auth.sendPasswordResetEmail(email: _email);
        final snackBar = SnackBar(
          content: Text("The email has been sent, please check your inbox"),
        );
        _fogetScaffodKey.currentState.showSnackBar(snackBar);
        new Future.delayed(const Duration(seconds: 1), () =>
            Navigator.of(context).pushNamedAndRemoveUntil(
                LoginPage.routeName, (Route<dynamic> route) => false));
      } catch(e) {
        final snackBar = SnackBar(
          content: Text(e.message),
        );
        _fogetScaffodKey.currentState.showSnackBar(snackBar);
      }
    }
  }
}