// import 'package:flutter/material.dart';



// Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Slidable(
                        
//                         actionPane: SlidableDrawerActionPane(),
                        
//                          secondaryActions: <Widget>[
//     new IconSlideAction(
//       caption: 'Delete',
//       color: Colors.red,
//       icon: Icons.delete,
//       onTap: () {
//         print("Delete Pressed");
//                         Firestore.instance
//                               .collection("cab_share").document(tempEntryId).delete();
//       },
//     ),
 
//   ],
                      
//                                               child: Container(
//                           padding: const EdgeInsets.all(4.0),
//                           decoration: BoxDecoration(border: Border.all(width: 1)),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   tempname != null ? Text(tempname) : Container(),
//                                   tempphone != null
//                                       ? Text(tempphone)
//                                       : Container(),
                                
//                                   tempphone != null
//                                       ? Text(tempDate)
//                                       : Container(),
//                                      tempTime != null
//                                       ? Text(tempTime)
//                                       : Container(),
//                                   Divider()
//                                 ],
//                               ),
//                    Container(
//                      padding: EdgeInsets.all(10),
//                      child: Column(
//                        children: <Widget>[
//                           tempDestination == "Railway"? Icon(Icons.train): Container(),
//                                          tempDestination == "Airport"? Icon(FontAwesomeIcons.plane): Container(),
//                                             tempDestination == "Bus Stop"? Icon(FontAwesomeIcons.bus): Container(),
//                        ],
//                      ),
//                    )
                                     
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               } else {
//                 return Center(
//                   child: Container(
//                     child: Text("No Cab Data Found"),
//                   ),
//                 );
//               }
//             }),
     
//     );