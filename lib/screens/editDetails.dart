import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './profile_page1.dart';

class EditDetails extends StatefulWidget {
  final String email;
  final String password;
  final String bankDetails;
  final String address;
  final String mobile;

  static const routeName = '/edit-details';
  EditDetails({this.email, this.password, this.address, this.bankDetails,this.mobile});

  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {

  final mobileController = TextEditingController();
  final bankController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();

  initialData() async {
    emailController.text = widget.email;
    addressController.text = widget.address;
    bankController.text = widget.bankDetails;
    passwordController.text = widget.password;
  }
@override
  void initState() {
    initialData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.green[600],
        title: Text(
          'Edit Details',
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
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  bottom: 40,
                  top: 20,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  controller: emailController,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  bottom: 40,
                  top: 20,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                  controller: addressController,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  bottom: 40,
                  top: 20,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Bank Details',
                  ),
                  controller: bankController,
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 30,
                  right: 30,
                  bottom: 40,
                  top: 20,
                ),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  controller: passwordController,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                width: 100,
                height: 40,
                child: RaisedButton(
                  padding: EdgeInsets.all(6),
                  color: Colors.green[600],
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
                  onPressed: () {
                    print(widget.mobile);
                    Firestore.instance.collection("Users").document(widget.mobile).updateData({
                      "Address": addressController.text,
                      "Email":emailController.text,
                      "Bank Details":bankController.text,
                      "Password" : passwordController.text, 
                    });
                     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfilePage1()));
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
