import 'package:flutter/material.dart';
import 'browse_page.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/loginPage';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'suyie001@gmail.com',
      decoration: new InputDecoration(
          hintText: 'Email',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );
  }

  Widget passwordSection() {
    return new TextFormField(
      autofocus: false,
      initialValue: 'some password',
      obscureText: true,
      decoration:  new InputDecoration(
          hintText: 'Password',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
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
            Navigator.of(context).pushNamed(BrowsePage.routeName);
          },
          color: Colors.blue,
          child: new Text('Log In',style: new TextStyle(color: Colors.white),),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: new Center(
          child: new ListView(
            shrinkWrap: true,
            padding: new EdgeInsets.only(left: 24.0,right: 24.0),
            children: <Widget>[
              logoSection(),
              SizedBox(height: 48.0),
              userNameSection(),
              SizedBox(height: 8.0,),
              passwordSection(),
              SizedBox(height: 24.0,),
              buttonSection(),

              new FlatButton(
                onPressed: (){},
                child: new Text('Forget Password?',style: new TextStyle(color: Colors.black54),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}