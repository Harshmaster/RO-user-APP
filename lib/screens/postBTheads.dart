import './Enquiry.dart';
import 'package:flutter/material.dart';
import './AddNew.dart';
import './Customer.dart';

class PostBtHead extends StatefulWidget {
  final String btHead;
  PostBtHead({this.btHead});
  @override
  _PostBtHeadState createState() => _PostBtHeadState();
}

class _PostBtHeadState extends State<PostBtHead>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddNew(
                        btHead: widget.btHead,
                      )));
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text("BUSINESS : ${widget.btHead.toString()}"),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          isScrollable: true,
          tabs: [
            Tab(
              child: Text('ENQUIRY'),
            ),
            Tab(
              child: Text('LEAD'),
            ),
            Tab(
              child: Text('CUSTOMER'),
            ),
            Tab(
              child: Text('OLD CUSTOMER'),
            ),
            Tab(
              child: Text('CANCELS'),
            )
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          onTap: (value) {
            // print(value);
          },
        ),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
          Enquiry(
            btHead: widget.btHead,
            cat: "Enquiry",
          ),
          Enquiry(
            btHead: widget.btHead,
            cat: "Lead",
          ),
          Customer(
            btHead: widget.btHead,
          ),
          Enquiry(
            btHead: widget.btHead,
            cat: "old-Customer",
          ),
          Enquiry(
            btHead: widget.btHead,
            cat: "Cancels",
          ),
        ],
        controller: _tabController,
      ),

      //GridView(
      //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      //     maxCrossAxisExtent: 200,
      //     childAspectRatio: 1.2,
      //     crossAxisSpacing: 20,
      //     mainAxisSpacing: 20,
      //   ),
      //   children: <Widget>[
      //     Card(
      //       elevation: 4,
      //       child: InkWell(
      //         onTap: (){
      //           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
      //             return AddNew(btHead:widget.btHead);
      //           }));
      //         },
      //         child: Center(
      //           child: Container(
      //             child: Text(
      //               "Add New",
      //               style: TextStyle(fontSize: 22),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Card(
      //       elevation: 4,
      //       child: InkWell(
      //         onTap: (){
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => Enquiry(btHead:widget.btHead)));
      //         },
      //         child: Center(
      //           child: Container(
      //             child: Text(
      //               "Enquiry",
      //               style: TextStyle(fontSize: 22),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Card(

      //       elevation: 4,
      //       child: InkWell(
      //         onTap: (){
      //           Navigator.push(context, MaterialPageRoute(builder: (context) => LeadStatus(btHead:widget.btHead)));
      //         },
      //         child: Center(
      //           child: Container(
      //             child: Text(
      //               "Lead",
      //               style: TextStyle(fontSize: 22),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Card(
      //       elevation: 4,
      //       child: InkWell(
      //         onTap: (){
      //            Navigator.push(context, MaterialPageRoute(builder: (context) => Customer(btHead:widget.btHead)));
      //         },
      //         child: Center(
      //           child: Container(
      //             child: Text(
      //               "Customer",
      //               style: TextStyle(fontSize: 22),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Card(
      //       elevation: 4,
      //       child: InkWell(
      //         onTap: (){
      //            Navigator.push(context, MaterialPageRoute(builder: (context) => Cancels(btHead:widget.btHead)));
      //         },
      //         child: Center(
      //           child: Container(
      //             child: Text(
      //               "Cancels",
      //               style: TextStyle(fontSize: 22),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     Card(
      //       elevation: 4,
      //       child: InkWell(
      //         onTap: (){
      //            Navigator.push(context, MaterialPageRoute(builder: (context) => OldCustomer(btHead:widget.btHead)));
      //         },
      //         child: Center(
      //           child: Container(
      //             child: Text(
      //               "Old Customer",
      //               style: TextStyle(fontSize: 22),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
