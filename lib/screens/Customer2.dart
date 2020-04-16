
import 'package:USERAPPRO/widgets/ViewTopCustomerData.dart';

import '../screens/EditClient.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Customer2 extends StatefulWidget {
  final String btHead;
  final String cat;
  Customer2({this.btHead, this.cat});
  @override
  _Customer2State createState() => _Customer2State();
}

class _Customer2State extends State<Customer2> {
  String sharedMobile;

  getSharedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sharedMobile = prefs.getString("sharedMobile");
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: sharedMobile != null
            ? StreamBuilder(
                stream: Firestore.instance
                    .collection("Clients")
                    .where("businessType", isEqualTo: widget.btHead)
                    .where("status", isEqualTo: "Customer")
                    .where("current_progress", isEqualTo: widget.cat)
                    .where("user_mobile", isEqualTo: sharedMobile)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            secondaryActions: <Widget>[
                              Container(
                                height: 110,
                                width: 60,
                                margin: EdgeInsets.only(
                                  top: 12,
                                ),
                                child: IconSlideAction(
                                  caption: "Delete",
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: () async {
                                    Firestore.instance
                                        .collection("Clients")
                                        .document(snapshot.data.documents[index]
                                            .data["client_id"])
                                        .delete();
                                  },
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 110,
                                margin: EdgeInsets.only(
                                  top: 12,
                                ),
                                child: IconSlideAction(
                                  caption: "Edit",
                                  color: Colors.black,
                                  icon: Icons.edit,
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                EditClient(
                                                    clientId: snapshot
                                                        .data
                                                        .documents[index]
                                                        .data["client_id"])));
                                  },
                                ),
                              ),
                            ],
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ViewTopCustomerData(
                                              docId: snapshot
                                                  .data
                                                  .documents[index]
                                                  .data["client_id"],
                                            )));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                margin:
                                    EdgeInsets.only(top: 10, left: 8, right: 8),
                                elevation: 0,
                                child: Container(
                                  height: 110,
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(10),
                                        width: 90,
                                        height: 90,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            child: Image.network(
                                              snapshot.data.documents[index]
                                                  .data["_picImageUrl"],
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 150,
                                            margin: EdgeInsets.only(
                                                top: 10, left: 5),
                                            child: Text(
                                              snapshot.data.documents[index]
                                                  .data["name"],
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: SizedBox(
                                            height: 1,
                                          )),
                                          Container(
                                            width: 70,
                                            height: 25,
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            margin: EdgeInsets.only(
                                                top: 5, left: 5),
                                            child: Center(
                                              child: Text(
                                                snapshot.data.documents[index]
                                                    .data["category"],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        width: 1,
                                      )),
                                      Icon(
                                        Icons.menu,
                                        size: 25,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return SpinKitCircle(color: Colors.black);
                  }
                })
            : SpinKitCircle(color: Colors.pink));
  }
}
