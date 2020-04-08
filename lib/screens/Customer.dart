import 'package:USERAPPRO/screens/Customer2.dart';
import 'package:flutter/material.dart';

class Customer extends StatefulWidget {
  final String btHead;
  Customer({this.btHead});
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicator: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              color: Colors.green,
            ),
            unselectedLabelColor: Colors.white,
            labelColor: Colors.amber,
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(
                  'PENDING',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'PROCESSING',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'TRANSIT',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'COMPLETE',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          bottomOpacity: 1,
        ),
      ),
      body: TabBarView(
        children: [
          Customer2(
            btHead: widget.btHead,
             cat: "Pending",
          ),
          Customer2(
            btHead: widget.btHead,
             cat: "Processing",
          ),
          Customer2(
            btHead: widget.btHead,
             cat: "Transit",
          ),
          Customer2(
            btHead: widget.btHead,
             cat: "Complete",
          ),
          Customer2(
            btHead: widget.btHead,
            cat: "Cancel",
          ),
        ],
        controller: _tabController,
      ),
    );
  }
}
