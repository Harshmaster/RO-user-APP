import '../screens/leads.dart';
import '../widgets/myAppbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyHomeLogin extends StatefulWidget {
  static const routeName = '/my-home-login';

  @override
  _MyHomeLoginState createState() => _MyHomeLoginState();
}

class _MyHomeLoginState extends State<MyHomeLogin> {
  final mobileController = TextEditingController();

  final passwordController = TextEditingController();

  bool _isLoggedIn;


  void storeData(BuildContext context) async {
    print(passwordController.text);
    print(mobileController.text);
    return await Firestore.instance
        .collection("Users")
        .where("Mobile", isEqualTo: mobileController.text.toString())
        .where("Password", isEqualTo: passwordController.text.toString())
        .getDocuments()
        .then((QuerySnapshot docs) async {
      print(docs.documents[0].data["Password"]);
      print(docs.documents[0].data["Mobile"]);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("sharedMobile", mobileController.text.toString());
      await prefs.setBool("isLoggedIn", true);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  Leads(id: mobileController.text)));
    });
  }

  getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool("isLoggedIn");
      
    });
    print(_isLoggedIn);
    if(_isLoggedIn){
        String passMobile;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        passMobile = prefs.getString("sharedMobile");
         Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Leads(
                        id: passMobile,
                      )));
    }

  }

  @override
  void initState() {
    getSharedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MyAppBar(),
              Container(
                padding: EdgeInsets.only(top: 14),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                width: double.infinity,
                margin: EdgeInsets.only(left: 30, right: 30, top: 60),
                height: 55,
                child: Container(
                  width: double.infinity,
                  height: 30,
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Phone',
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                    ),
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 14),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                width: double.infinity,
                margin: EdgeInsets.all(30),
                height: 55,
                child: Container(
                  width: double.infinity,
                  height: 30,
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                    ),
                    controller: passwordController,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(242, 7, 158, 1),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(242, 7, 158, 1).withOpacity(1),
                        Color.fromRGBO(209, 18, 87, 1).withOpacity(0.8),
                        Color.fromRGBO(219, 22, 13, 1).withOpacity(0.78),
                        Color.fromRGBO(239, 83, 31, 0.9895308465182948)
                            .withOpacity(1),
                      ],
                    )),
                child: RaisedButton(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SpinKitCircle(color: Colors.pink);
                        });
                    storeData(context);
                  },
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ));
  }
}
