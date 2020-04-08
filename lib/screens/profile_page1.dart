import '../screens/editDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage1 extends StatefulWidget {
  static const routeName = '/profile-page-1';

  @override
  _ProfilePage1State createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage1> {
  String mobile = '';
  String address = '';
  String password = '';
  String bankdetails;
  String email = '';
  String name = '';
  String _imgLink = '';
  String sharedMobile = '';

  getData() async {
    sharedMobile = await getSharedData();
    print(sharedMobile);
    await Firestore.instance
        .collection("Users")
        .where("Mobile", isEqualTo: sharedMobile)
        .getDocuments()
        .then((QuerySnapshot docs) {
      if (docs.documents.isEmpty) {
        print("IT IS FUCKIN EMPTY");
      }
      setState(() {
        email = docs.documents[0].data["Email"];
        mobile = sharedMobile;
        password = docs.documents[0].data["Password"];
        name = docs.documents[0].data["Name"];
        address = docs.documents[0].data["Address"];
        _imgLink = docs.documents[0].data["_imgLink"];
        bankdetails = docs.documents[0].data["Bank Details"];
        
      });
    });
  }

  getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("sharedMobile").toString();
  }

  @override
  void initState() {
    getSharedData();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bankdetails != null
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                          child: Image.network(
                            _imgLink,
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white,
                          margin: EdgeInsets.all(0),
                          width: double.infinity,
                          height: 315,
                        ),
                        Positioned(
                          bottom: 20,
                          left: 35,
                          child: Text(
                            name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 27),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          bottom: -24,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EditDetails(
                                            email: email,
                                            bankDetails: bankdetails,
                                            address : address,
                                            password : password,
                                            mobile: mobile,
                                          )));
                            },
                            child: Icon(Icons.edit),
                            backgroundColor: Colors.pink,
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(35),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Mobile',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            mobile,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 35, right: 35, top: 0, bottom: 35),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 35, right: 35, top: 0, bottom: 35),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Bank Details',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            bankdetails,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 35, right: 35, top: 0, bottom: 35),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            address,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 35, right: 35, top: 0, bottom: 35),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            password,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : SpinKitCircle(color: Colors.pink));
  }
}
