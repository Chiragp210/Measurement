import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:measurement/AddPage.dart';
import 'package:measurement/HomePage.dart';
import 'package:measurement/UpdatePage.dart';

class DisplayData extends StatefulWidget{
  const DisplayData({super.key});
  @override
  State<StatefulWidget> createState() => _DisplayDataState();

}

class _DisplayDataState extends State<DisplayData> {
  final Stream<QuerySnapshot> customerStream = FirebaseFirestore.instance.collection('Customerdetails').snapshots();
  CollectionReference customers = FirebaseFirestore.instance.collection('Customerdetails');
  Future<void>deleteUser(id){
    //print("User Deleted $id");
    return customers.doc(id).delete().then((value)=>
        Fluttertoast.showToast(
            msg: "User Deleted",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        )).catchError((error) =>
        Fluttertoast.showToast(
            msg: "Faild to Delete User:$error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        )
        );
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream: customerStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
    {
      if (snapshot.hasError) {
        print("Something Wrong");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      final List storedocs = [];
      snapshot.data!.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> a = document.data() as Map<String, dynamic>;
        storedocs.add(a);
        a['id'] = document.id;
      }).toList();

      // print(storedocs[1]);

      return Scaffold(
        appBar: AppBar(title: const Text(
            'Display Page', style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center),
          backgroundColor: Colors.deepOrangeAccent,),
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.deepPurple,
                      Colors.indigoAccent
                    ]
                )
            ),
            child:Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    border: TableBorder.all(color: Colors.white),
                    columnWidths: const <int, TableColumnWidth>{
                      1: FixedColumnWidth(70),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                              child: Container(
                                color: Colors.blue,
                                child: const Center(
                                  child: Text('Customer Details',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                                ),
                              )
                          ),
                          TableCell(
                              child: Container(
                                color: Colors.blue,
                                child: const Center(
                                  child: Text("",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                                ),
                              )
                          ),
                        ]
                      ),
                      for(var i = 0;i<storedocs.length;i++) ...[
                        TableRow(
                            children: [
                              TableCell(child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          const Text("Name: ",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                                          Text(storedocs[i]['Name'],style: const TextStyle(fontSize: 18.0,color: Colors.white))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Mobile No.: ",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                                          Text(storedocs[i]['MobileNo'].toString(),style: const TextStyle(fontSize: 18.0,color: Colors.white))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Add: ",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                                          Text(storedocs[i]['Address'],style: const TextStyle(fontSize: 18.0,color: Colors.white))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Item: ",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                                          Text(storedocs[i]['ItemType'].toString(),style: const TextStyle(fontSize: 18.0,color: Colors.white))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Height 1: ",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                                          Text(storedocs[i]['Height1'].toString(),style: const TextStyle(fontSize: 18.0,color: Colors.white))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Height 2: ",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                                          Text(storedocs[i]['Height2'].toString(),style: const TextStyle(fontSize: 18.0,color: Colors.white))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Width 1: ",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                                          Text(storedocs[i]['Width1'].toString(),style: const TextStyle(fontSize: 18.0,color: Colors.white))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Width 2: ",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                                          Text(storedocs[i]['Width2'].toString(),style: const TextStyle(fontSize: 18.0,color: Colors.white))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Cross 1: ",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                                          Text(storedocs[i]['Cross1'].toString(),style: const TextStyle(fontSize: 18.0,color: Colors.white))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text("Cross 2: ",style: TextStyle(fontSize: 18.0,color: Colors.white)),
                                          Text(storedocs[i]['Cross2'].toString(),style: const TextStyle(fontSize: 18.0,color: Colors.white))
                                        ],
                                      ),
                                    ],
                                  )
                              )
                              ),
                              TableCell(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => UpdateData(id: (storedocs[i]['id'])),
                                      )
                                  ), icon: const Icon(Icons.edit), color: Colors.yellowAccent ),
                                  IconButton(onPressed: () =>
                                  {deleteUser(storedocs[i]['id'])}, icon: const Icon(Icons.delete),color: Colors.red,
                                  ),
                                ],
                              )
                              ),
                            ]
                        )
                      ]
                    ],
                  ),
                )
            )
        ),
        floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22.0),
        onOpen: () => "Open Dial",
        onClose: () => "Dial Close",
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.deepOrangeAccent,
            onTap: () =>
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddData())),
            label: 'Add Data',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white),
            labelBackgroundColor: Colors.deepOrangeAccent,
          ),
          SpeedDialChild(
            child: const Icon(Icons.home, color: Colors.white),
            backgroundColor: Colors.deepOrangeAccent,
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const MyHomePage())),
            label: 'Home Page',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.white),
            labelBackgroundColor: Colors.deepOrangeAccent,
          ),
        ],
      )
      );
    }
    );
  }
}