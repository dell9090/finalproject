import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';


import 'dart:io';
import 'dart:async';
import 'browse_page.dart';
import 'structure.dart';
import 'login_page.dart';

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
    },
  ));
}

class PostPage extends StatefulWidget {
  static String routeName = "/postPage";
  final FirebaseStorage storage;
  PostPage({Key key, this.storage}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _PostPageState(storage: storage);
}

class _PostPageState extends State<PostPage> {
  final FirebaseStorage storage;

  var hintTips = new TextStyle(fontSize: 15.0, color: Colors.black45);
  var _titleController = new TextEditingController();
  var _priceController = new TextEditingController();
  var _descriptionController = new TextEditingController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> photoList = new List();
  List<String> firePathList = new List();

  bool ifPhoto = false;

  _PostPageState({Key key, this.storage});

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _inputphoto(String path) {
    photoList.add(path);
    ifPhoto = true;
    print("rebuild path:  ${path}");
  }

  Future<String> _uploadFile(String path) async {
    StorageReference ref = FirebaseStorage.instance.ref().child("data/${basename(path)}");
    StorageUploadTask uploadTask = ref.putFile(File(path));

    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url = downUrl.toString();
    firePathList.add(url);

    print("download url: ${url}");
    return url;
  }

  _updatePath(String title, String price, String description) async {
    for (String path in photoList) {
      await _uploadFile(path);
    }
    PostDetial item = new PostDetial(title, price, description, firePathList);
    await Firestore.instance.collection('salelist').document().setData(item.toJson());
  }

  @override
  Widget build(BuildContext context) {
    final PostDetial args = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text("New Post", style: new TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[
          //PostTab(scaffoldKey: _scaffoldKey,),
          buttonSection(context),
        ],
      ),

      body: Center(
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            titleSection(),
            priceSection(),
            descripSection(),
            new Flexible(
              flex: 1,
              child: photoSection(),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_enhance),
          onPressed: () {
            if (photoList.length < 4) {
              Navigator.pushNamed(context, TakePictureScreen.routeName).then((value) {
                _inputphoto(value);
              });
            } else {
              showDialog(
                context: context,
                child: new SimpleDialog(
                  contentPadding: const EdgeInsets.all(10.0),
                  title: new Center(
                    child: Text("You can\'t add more photos"),
                  ),
                  children: <Widget>[
                    new Center(
                      child: Text("the max photo you can attach is 4"),
                    ),
                    new Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                  ],
                ),
              );
            }
          }
      ),
    );

  }

  Widget buttonSection(BuildContext context) {

    const demoPlugin = const MethodChannel('demo.plugin');

    return new FlatButton(
      textColor: Colors.white,
      child: Text(
        "Post",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {

        // post new item to firebase

        String title = _titleController.text;
        String price = _priceController.text;
        String description = _descriptionController.text;

        if (title == "" || price == "" || description == "") {
          final snackBar = SnackBar(
            content: Text("Please Complete all information!"),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        } else {

          _updatePath(title, price, description);

          //demoPlugin.invokeMethod('interaction');

          final snackBar = SnackBar(
            content: Text("You post successfully!"),
//          action: SnackBarAction(
//              label: 'Undo',
//              onPressed: () {
//                //undo action
//              }
//          ),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);

          //new Future.delayed(const Duration(seconds: 1), () => Navigator.of(context).pushNamed(BrowsePage.routeName));
          new Future.delayed(const Duration(seconds: 1), () => Navigator.of(context).pop());
        }
      },
    );
  }

  Widget titleSection () {
    return Column(
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.all(8.0),
        ),

        new TextField(
          style: hintTips,
          controller: _titleController,
          decoration: new InputDecoration(
            hintText: "Enter title of the item",
            contentPadding: new EdgeInsets.only(bottom: 5.0),
            //errorText: errorMessage
          ),
        ),
      ],
    );

  }

  Widget priceSection() {
    return Column(
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.all(8.0),
        ),

        new TextField(
          style: hintTips,
          controller: _priceController,
          decoration: new InputDecoration(
              hintText: "Enter price",
              contentPadding: new EdgeInsets.only(bottom: 5.0)
          ),
        ),
      ],
    );
  }

  Widget descripSection() {
    return Column(
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.all(8.0),
        ),

        new TextField(
          style: hintTips,
          controller: _descriptionController,
          decoration: new InputDecoration(
              hintText: "Enter description of the item",
              contentPadding: new EdgeInsets.only(bottom: 200.0)
          ),
        ),
      ],
    );
  }

  Widget photoSection() {
    if (ifPhoto) {
      print("photo count: ${photoList.length}");
      return  GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
        primary: false,
        children: _getGrid(),
        shrinkWrap: true,
      );
    }
    return Text('No photo attached');
  }

  List<Widget> _getGrid() {
    List<Widget> gridList = new List();
    for (int i = 0; i < photoList.length; i++) {
      gridList.add(photoGridItem(photoList[i]));
    }
    return gridList;
  }

  Widget photoGridItem(String path) {
    return Container(
      child: Image.file(
        File(path),
        fit: BoxFit.contain,
        width: 20,
        height: 20,
      ),
    );
    //return Text("test");
  }
}

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  static String routeName ="/cameraPage";
  const TakePictureScreen({
    Key key,
    @required this.camera,
  }) : super(key : key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),

      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator
            return Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),

        // press take photos button
        onPressed: () async {
          // pass the photo to the cloud and display it on screen
          try {
            await _initializeControllerFuture;

            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            await _controller.takePicture(path);

            Navigator.of(context).pop(path);

          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}

