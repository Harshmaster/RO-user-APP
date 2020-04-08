import 'dart:io';
import 'package:USERAPPRO/screens/leads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';

class AddNew extends StatefulWidget {
  final String btHead;
  AddNew({this.btHead});
  static const routeName = '/ADDLEADS';
  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  bool _isCustomer = false;

  List<String> statusName = [
    'Enquiry',
    'Lead',
    'Customer',
    'Cancels',
    'old-Customer'
  ];
  String selectedUser;

  final areaController = TextEditingController();
  final priceController = TextEditingController();
  final noteController = TextEditingController();
  final contactnameController = TextEditingController();
  final contactController = TextEditingController();
  final categoryController = TextEditingController();
  final quantityController = TextEditingController();
  final serviceController = TextEditingController();
  final unitController = TextEditingController();
  final slotController = TextEditingController();
  final gstController = TextEditingController();

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
    await Firestore.instance.collection("Clients").document(uuid).setData({
      "name": contactnameController.text,
      "area": areaController.text,
      "note": noteController.text,
      "price": priceController.text,
      "user_mobile": sharedMobile,
      "mobile": contactController.text,
      "category": categoryController.text,
      "_shopImageUrl": _shopImageUrl,
      "_visitingImageUrl": _visitingImageUrl,
      "client_id": uuid,
      "status": selectedUser,
      "businessType": widget.btHead,
      "_picImageUrl": _picImageUrl,
      "gst_no": gstController.text,
    });
  }

  uploadCustomerData() async {
    sharedMobile = await getSharedData();
    await Firestore.instance.collection("Clients").document(uuid).setData({
      "name": contactnameController.text,
      "area": areaController.text,
      "note": noteController.text,
      "price": priceController.text,
      "user_mobile": sharedMobile,
      "mobile": contactController.text,
      "category": categoryController.text,
      "_shopImageUrl": _shopImageUrl,
      "_visitingImageUrl": _visitingImageUrl,
      "client_id": uuid,
      "status": selectedUser,
      "current_progress": "Pending",
      "quantity_per_day": quantityController.text,
      "service_day": serviceController.text,
      "unit_price": unitController.text,
      "Slot": slotController.text,
      "businessType": widget.btHead,
      "_picImageUrl": _picImageUrl,
      "gst_no": gstController.text,
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
        FirebaseStorage.instance.ref().child('clients/$id');
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
        FirebaseStorage.instance.ref().child('clients/$id');
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
        FirebaseStorage.instance.ref().child('clients/$id');
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
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(20),
        //     bottomRight: Radius.circular(20),
        //   ),
        //),
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          'Add New',
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
                  onPressed: () {},
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
                    Icon(Icons.confirmation_number),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(hintText: 'GST NO.'),
                          controller: gstController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _isCustomer == true
                  ? Container(
                      child: Column(
                        children: <Widget>[
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
                                Icon(Icons.confirmation_number),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    width: 200,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Quantity Per Day'),
                                      controller: quantityController,
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
                                Icon(Icons.settings_system_daydream),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    width: 200,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Service Day'),
                                      controller: serviceController,
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
                                    width: 200,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Unit Price'),
                                      controller: unitController,
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
                                Icon(Icons.view_day),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    width: 200,
                                    child: TextField(
                                      decoration:
                                          InputDecoration(hintText: 'Slot'),
                                      controller: slotController,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 30,
                  underline: Container(
                    color: Colors.white,
                  ),
                  style: TextStyle(
                      color: Color.fromRGBO(82, 90, 101, 1),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  hint: Text('Select Status'),
                  value: selectedUser,
                  onChanged: (String value) {
                    setState(() {
                      selectedUser = value;
                      if (value == "Customer") {
                        _isCustomer = true;
                      } else {
                        _isCustomer = false;
                      }
                    });
                  },
                  items: statusName.map(
                    (String variable) {
                      return DropdownMenuItem<String>(
                        value: variable,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Text(variable),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
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
                          return SpinKitCircle(color: Colors.white);
                        });

                    await uploadVisitingImage().then((dynamic docs1) async {
                      return await uploadShopImage()
                          .then((dynamic docs2) async {
                        return await uploadPicImage()
                            .then((dynamic docs3) async {
                          if (_isCustomer) {
                            print("CUSTOMER DATA UPLOADED");
                            return await uploadCustomerData();
                          }
                           else {
                             print("UPLOADED NORMAL DATA");
                            return await uploadData();
                          }
                        });
                      });
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Leads()));
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
