import 'package:USERAPPRO/screens/home_login_page.dart';
import 'package:USERAPPRO/screens/postBTheads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/add_leads.dart';
import '../screens/profile_page1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Leads extends StatefulWidget {
  final String id;
  static const routeName = '/show-leads';
  Leads({this.id});

  @override
  _LeadsState createState() => _LeadsState();
}

class _LeadsState extends State<Leads> {
  String sharedMobile;
  getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sharedMobile = prefs.getString("sharedMobile");
    });
  }

  @override
  void initState() {
    getSharedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(
            AddLeads.routeName,
          );
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        // shape: RoundedRectangleBorder(
        //   // borderRadius: BorderRadius.circular(10),
        // ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(9),
            child: IconButton(
              icon: Icon(Icons.dashboard, size: 30),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  ProfilePage1.routeName,
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 9,
              bottom: 9,
              right: 0,
            ),
            child: IconButton(
              icon: Icon(Icons.add, size: 30),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLoggedIn", false).then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyHomeLogin()));
                  print("LOGGED OUT ");
                });
              },
            ),
          ),
        ],
        title: Text(
          'Business Types',
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: Colors.black,
      ),

      // body: Container(
      //   child: Container(
      //     width: double.infinity,
      //     child: StreamBuilder(
      //       stream: Firestore.instance
      //           .collection("Leads")
      //           .where("user_mobile", isEqualTo: widget.id)
      //           .snapshots(),
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData) {
      //           return ListView.builder(
      //             itemCount: snapshot.data.documents.length,
      //             shrinkWrap: true,
      //             itemBuilder: (context, index) {
      //               return MyCard(
      //                 name: snapshot.data.documents[index].data["name"],
      //                 note: snapshot.data.documents[index].data["note"],
      //                 price: snapshot.data.documents[index].data["price"],
      //                 area: snapshot.data.documents[index].data["area"],
      //                 category: snapshot.data.documents[index].data["category"],
      //                 id: snapshot.data.documents[index].data["lead_id"],
      //               );
      //             },
      //           );
      //         } else {
      //           return SpinKitCircle(color: Colors.pink);
      //         }
      //       },
      //     ),
      //   ),
      // ),

      body: sharedMobile != null
          ? StreamBuilder(
              stream: Firestore.instance
                  .collection("Users")
                  .document(sharedMobile)
                  .collection("Business Types")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => PostBtHead(
                                        btHead: snapshot.data.documents[index]
                                            .data["value"],
                                      )));
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  width: 100,
                                  height: 100,
                                  child: Image.network(
                                    snapshot
                                        .data.documents[index].data["_imgLink"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  snapshot.data.documents[index].data["value"],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                  );
                } else {
                  return SpinKitCircle(color: Colors.pink);
                }
              },
            )
          : SpinKitCircle(color: Colors.pink),
    );
  }
}
