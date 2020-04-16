import 'dart:io';
import '../screens/BTheads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocation/geolocation.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class AddLeads extends StatefulWidget {
  static const routeName = '/ADDLEADS';
  @override
  _AddLeadsState createState() => _AddLeadsState();
}

class _AddLeadsState extends State<AddLeads> {
  MapController controller = MapController();
  double latitude;
  double longitude;

  getPermission() async {
    final GeolocationResult result =
        await Geolocation.requestLocationPermission(
            permission: const LocationPermission(
                android: LocationPermissionAndroid.fine,
                ios: LocationPermissionIOS.always));
    return result;
  }

  getLocation() async {
    return getPermission().then((result) async {
      if (result.isSuccessful) {
        final coords =
            Geolocation.currentLocation(accuracy: LocationAccuracy.best);
        return coords;
      } else {
        return null;
      }
    });
  }

  buildMap() async {
    await getLocation().then((response) {
      response.listen((value) {
        latitude = value.location.latitude;
        longitude = value.location.longitude;
      });
    });
  }

  final areaController = TextEditingController();
  final priceController = TextEditingController();
  final noteController = TextEditingController();
  final contactnameController = TextEditingController();
  final contactController = TextEditingController();
  final categoryController = TextEditingController();

  String sharedMobile;

  String _shopImageUrl;
  String _visitingImageUrl;
  String _picImageUrl;

  File _shopImage;
  File _visitingImage;
  File _picImage;

  var uuid = Uuid().v4();

  uploadData() async {
    sharedMobile = await getSharedData();
    Firestore.instance.collection("Leads").document(uuid).setData({
      "name": contactnameController.text,
      "area": areaController.text,
      "note": noteController.text,
      "price": priceController.text,
      "user_mobile": sharedMobile,
      "mobile": contactController.text,
      "category": categoryController.text,
      "_shopImageUrl": _shopImageUrl,
      "_visitingImageUrl": _visitingImageUrl,
      "lead_id": uuid,
      "_picImageUrl": _picImageUrl,
      "latitude":latitude,
      "longitude":longitude,
    });
  }

  getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("sharedMobile");
  }

  getShopImage() async {
    print("Upload image");
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _shopImage = image;
    });
  }

  Future<dynamic> uploadShopImage() async {
    String id = Uuid().v4();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('leads/$id');
    StorageUploadTask uploadTask = storageReference.putFile(_shopImage);
    await uploadTask.onComplete;
    print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      _shopImageUrl = fileURL;
      print("THIS IS SHOP : $_shopImageUrl");
    });
  }

  Future<dynamic> uploadPicImage() async {
    String id = Uuid().v4();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('leads/$id');
    StorageUploadTask uploadTask = storageReference.putFile(_picImage);
    await uploadTask.onComplete;
    print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      _picImageUrl = fileURL;
      print("THIS IS SHOP : $_shopImageUrl");
    });
  }

  getPicImage() async {
    print("Upload image");
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _picImage = image;
    });
  }

  getVisitingImage() async {
    print("Upload image");
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _visitingImage = image;
    });
  }

  Future<dynamic> uploadVisitingImage() async {
    String id = Uuid().v4();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('leads/$id');
    StorageUploadTask uploadTask = storageReference.putFile(_visitingImage);
    await uploadTask.onComplete;
    print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      _visitingImageUrl = fileURL;
      print("THIS IS Visiting : $_visitingImageUrl");
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          'Add New Lead',
          style: TextStyle(
            fontSize: 23,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: getVisitingImage,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10, top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(),
                            // color: Colors.blue[700],
                          ),
                          width: 100,
                          height: 100,
                          child: _visitingImage == null
                              ? Center(
                                  child: Icon(
                                  Icons.photo_camera,
                                  size: 50,
                                ))
                              : Container(
                                  child: Image.file(
                                    _visitingImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'V.CARD',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: getPicImage,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10, top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(),
                            // color: Colors.blue[700],
                          ),
                          width: 100,
                          height: 100,
                          child: _picImage == null
                              ? Center(
                                  child: Icon(
                                  Icons.picture_in_picture,
                                  size: 50,
                                ))
                              : Container(
                                  child: Image.file(
                                    _picImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'PIC',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: getShopImage,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10, top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(),
                            // color: Colors.blue[700],
                          ),
                          width: 100,
                          height: 100,
                          child: _shopImage == null
                              ? Center(
                                  child: Icon(
                                  Icons.shop,
                                  size: 50,
                                ))
                              : Container(
                                  child: Image.file(
                                    _shopImage,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'SHOP',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(0),
                width: 150,
                child: RaisedButton(
                  color: Colors.black,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'PING LOCATION',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.place,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () async {
                    await buildMap();
                    print(latitude);
                    print(longitude);
                  },
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Name'),
                          controller: contactnameController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.phone_android),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Mobile'),
                          controller: contactController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.attach_money),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Price'),
                          controller: priceController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.note),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Note'),
                          controller: noteController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.place),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Area'),
                          controller: areaController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 10,
                  top: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.category),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(hintText: 'Category'),
                          controller: categoryController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: 100,
                height: 40,
                child: RaisedButton(
                  padding: EdgeInsets.all(6),
                  color: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () async {
                    showDialog(
                        context: (context),
                        builder: (context) {
                          return SpinKitCircle(color: Colors.pink);
                        });

                    await uploadVisitingImage().then((dynamic docs1) async {
                      return await uploadShopImage()
                          .then((dynamic docs2) async {
                        return await uploadPicImage()
                            .then((dynamic docs3) async {
                          return await uploadData();
                        });
                      });
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => BtHeads()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
