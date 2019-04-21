import 'login_page.dart';
import 'browse_page.dart';
import 'post_page.dart';
import 'forget_password_page.dart';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> main() async{

  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  final FirebaseStorage storage = new FirebaseStorage();

  runApp(MaterialApp(
    title: 'My App',
    //home: MainPage(),
    home: LoginPage(),
    routes: {
      PostPage.routeName: (context) => new PostPage(),
      TakePictureScreen.routeName : (context) => new TakePictureScreen(camera: firstCamera),
      BrowsePage.routeName: (context) => new BrowsePage(),
      LoginPage.routeName: (context) => new LoginPage(),
      ForgetPage.routeName: (context) => new ForgetPage(),
    },
  ));
}