import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './postBTheads.dart';

class BtHeads extends StatefulWidget {
  @override
  _BtHeadsState createState() => _BtHeadsState();
}

class _BtHeadsState extends State<BtHeads> {
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
    print("WOWOWO $sharedMobile");
    return Scaffold(
        appBar: AppBar(
          title: Text("All BT Heads"),
        ),
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
                                    builder: (BuildContext context) =>
                                        PostBtHead(btHead: snapshot.data.documents[index]
                                          .data["value"],)));
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
                                      snapshot.data.documents[index]
                                          .data["_imgLink"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    snapshot
                                        .data.documents[index].data["value"],
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
                  }
                  else{
                    return SpinKitCircle(color:Colors.pink);
                  }
                },
              )
            : SpinKitCircle(color: Colors.pink));
  }
}
