import 'package:flutter/material.dart';
import 'browse_page.dart';
import 'forget_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/loginPage';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _sKey = GlobalKey<ScaffoldState>();

  Widget logoSection() {
    return new Hero(
      tag: 'hero',
      child: new CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: new Image.asset('images/logo.png'),
      ),
    );
  }

  Widget userNameSection() {
    return new TextFormField(
      validator: (input){
        if(input.isEmpty) {
          return 'Please enter your email';
        }
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'liux3721@gmail.com',
      decoration: new InputDecoration(
          hintText: 'Email',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
      onSaved: (input) => _email = input,
    );
  }

  Widget passwordSection() {
    return new TextFormField(
      validator: (input) {
        if(input.length < 6){
          return "Longer password required";
        }
      },
      autofocus: false,
      initialValue: 'liux3721',
      obscureText: true,
      decoration:  new InputDecoration(
          hintText: 'Password',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
      onSaved: (input) => _password = input,
    );
  }

  Widget buttonSection() {
    return new Padding(
      padding: new EdgeInsets.symmetric(vertical: 16.0),
      child: new Material(
        borderRadius: BorderRadius.circular(32.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: new MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
             singIn();
          },
          color: Colors.blue,
          child: new Text('Log In',style: new TextStyle(color: Colors.white),),
        ),
      ),
    );
  }

  Widget forgetPasswordSection() {
    return new FlatButton(
      onPressed: (){
        Navigator.of(context).pushNamed(ForgetPage.routeName);
      },
      child: new Text('Forget Password?',style: new TextStyle(color: Colors.black54),),
    );
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      key: _sKey,
      backgroundColor: Colors.white,
      body: new Center(
            child: new ListView(
              shrinkWrap: true,
              padding: new EdgeInsets.only(left: 24.0,right: 24.0),
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      logoSection(),
                      SizedBox(height: 48.0),
                      userNameSection(),
                      SizedBox(height: 8.0,),
                      passwordSection(),
                    ],
                  ),
                ),

                SizedBox(height: 24.0,),
                buttonSection(),
                forgetPasswordSection(),

              ],
            ),
          ),
    );
  }


  void singIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email, password: _password);
        Navigator.of(context).pushNamedAndRemoveUntil(
            BrowsePage.routeName, (Route<dynamic> route) => false);
      } catch(e) {
        final snackBar = SnackBar(
          content: Text(e.message),
        );
        _sKey.currentState.showSnackBar(snackBar);
      }
    }
  }
}

