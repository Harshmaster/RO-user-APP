import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../screens/ViewLead.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyCard extends StatelessWidget {
  final String name;
  final String price;
  final String area;
  final String category;
  final String note;
  final String id;

  MyCard({
    this.area,
    this.category,
    this.name,
    this.note,
    this.price,
    this.id,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        
        showDialog(context:context,builder: (context){
          return SpinKitCircle(color:Colors.pink);
        });

        Firestore.instance
            .collection("Leads")
            .document(this.id)
            .get()
            .then((DocumentSnapshot docs) {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => CompleteLead(snap:docs)));
        });
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.all(15),
        child: Container(
          height: 250,
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Customer Name',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 10,
                      ),
                    ),
                    Text(
                      'Note',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: 124,
                        width: 200,
                        child: Text(
                          note,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 90,
                height: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Price',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            "₹$price",
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.w800,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 13),
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Category',
                            style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            category,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 72,
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Area',
                            style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            area,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
