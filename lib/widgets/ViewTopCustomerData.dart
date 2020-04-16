import 'package:USERAPPRO/widgets/ViewCustomertabBar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ViewTopCustomerData extends StatefulWidget {
  final String docId;
  ViewTopCustomerData({this.docId});

  @override
  _ViewTopCustomerDataState createState() => _ViewTopCustomerDataState();
}

class _ViewTopCustomerDataState extends State<ViewTopCustomerData> {
  String name;
  String price;
  String mobile;
  String note;
  String category;
  String area;
  String businessType;
  String _picImageUrl;
  String gst_no;
  String status;

  getData() async {
    await Firestore.instance
        .collection("Clients")
        .document(widget.docId)
        .get()
        .then((DocumentSnapshot docs) {
      setState(() {
        name = docs["name"];
        price = docs["price"];
        mobile = docs["mobile"];
        note = docs["note"];
        category = docs["category"];
        area = docs["area"];
        businessType = docs["businessType"];
        status = docs["status"];
        _picImageUrl = docs["_picImageUrl"];
        gst_no = docs["gst_no"];
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.view_list,
              color: Colors.black,
            ),
          )
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "DATA VIEW",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: "ComicNeue-Light"),
        ),
      ),
      body: status != null
          ? SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 80,
                      margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13)),
                            width: 80,
                            height: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: Image.network(
                                _picImageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(name,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "ComicNeue-Bold",
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text("GSTIN : ",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "ComicNeue-Bold",
                                        )),
                                    Text("$gst_no"),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text("BUSINESS : ",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "ComicNeue-Bold",
                                        )),
                                    Text("$businessType"),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 10,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Text(
                              status,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:20),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        child: CustomerTabBar(docId: widget.docId)),
                  ],
                ),
              ),
            )
          : SpinKitCircle(color: Colors.black),
    );
  }
}
