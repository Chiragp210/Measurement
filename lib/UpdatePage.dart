import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateData extends StatefulWidget{
  final String id;
  UpdateData({super.key, required this.id});
  @override
  _UpdateDataState createState() => _UpdateDataState();

}

class _UpdateDataState extends State<UpdateData> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _itemstype = <String>[
    'Door',
    'Window',
    'Gate'
  ];
  var selectedType;

  CollectionReference customers = FirebaseFirestore.instance.collection('Customerdetails');
  Future<void> updateUser(did,name,mobile,address,selectedType,height1,height2,width1,width2,cross1,cross2){
    return customers.doc(did).update({'Name':name,'MobileNo':int.parse(mobile.toString()),'Address':address,'ItemType':selectedType.toString(),'Height1':double.parse(height1.toString()),'Height2':double.parse(height2.toString()),'Width1':double.parse(width1.toString()),'Width2':double.parse(width2.toString()),'Cross1':double.parse(cross1.toString()),'Cross2':double.parse(cross2.toString())}).then((value)=>
        Fluttertoast.showToast(
            msg: "Update User",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        )).catchError((error) => Fluttertoast.showToast(
        msg: "Faild to Update User:$error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(
        'Update Data Page', style: TextStyle(color: Colors.white),
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
            child: Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 30.0),
                    child: FutureBuilder<DocumentSnapshot <Map <String,dynamic>>>(
                      future: FirebaseFirestore.instance.collection('Customerdetails').doc(widget.id).get(),
                      builder: (_,snapshot){
                      if(snapshot.hasError){
                      print("Something Went Wrong");
                      }
                      if(snapshot.connectionState == ConnectionState.waiting)
                      {
                      return Center(child: CircularProgressIndicator(),);
                      }
                      var data = snapshot.data!.data();
                      var did = widget.id;
                      var name = data!['Name'];
                      var mobile = data!['MobileNo'];
                      var address = data!['Address'];
                      var item = data!['ItemType'];
                      var height1 = data!['Height1'];
                      var height2 = data!['Height2'];
                      var width1 = data!['Width1'];
                      var width2 = data!['Width2'];
                      var cross1 = data!['Cross1'];
                      var cross2 = data!['Cross2'];
                    return ListView(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              autofocus: false,
                              initialValue: name,
                              cursorColor: Colors.white,
                              style: const TextStyle(fontSize: 20.0,color: Colors.white),
                              onChanged: (value) => name = value,
                              decoration: const InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                errorStyle:
                                TextStyle(color: Colors.redAccent, fontSize: 15.0),
                              ),
                              validator: (value){
                                if (value == null || value.isEmpty)
                                {
                                  return "Please Enter Name";
                                }
                                return null;
                              },
                            )
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              autofocus: false,
                              initialValue: mobile.toString(),
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.white,
                              style: const TextStyle(fontSize: 20.0,color: Colors.white),
                              onChanged: (value) => mobile = value,
                              decoration: const InputDecoration(
                                labelText: "Mobile No.",
                                labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,)),
                                errorStyle:
                                TextStyle(color: Colors.redAccent, fontSize: 15.0),
                              ),
                              validator: (value){
                                if (value == null || value.isEmpty)
                                {
                                  return "Please Enter Number";
                                }
                                else if(!RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$').hasMatch(value)){
                                  return "Please Enter Valid Number";
                                }
                                return null;
                              },
                            )
                        ),

                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              autofocus: false,
                              initialValue: address,
                              cursorColor: Colors.white,
                              style: const TextStyle(fontSize: 20.0,color: Colors.white),
                              onChanged: (value) => address = value,
                              decoration: const InputDecoration(
                                labelText: "Address",
                                labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                errorStyle:
                                TextStyle(color: Colors.redAccent, fontSize: 15.0),
                              ),
                              validator: (value){
                                if (value == null || value.isEmpty)
                                {
                                  return "Please Enter Address";
                                }
                                return null;
                              },
                            )
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: DropdownButton(items: _itemstype.map((value)=>DropdownMenuItem(child: Text(
                              value,style: TextStyle(color: Colors.black,fontSize: 18)),
                            value: value,


                          )).toList(), onChanged: (seletedItemType) {
                            setState(() {
                              selectedType = seletedItemType;
                            });
                          },
                            value: selectedType,

                            isExpanded:false,
                            hint: Text(item, style: TextStyle(color: Colors.white,fontSize: 18),),
                          ),

                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              autofocus: false,
                              initialValue: height1.toString(),
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.white,
                              style: const TextStyle(fontSize: 20.0,color: Colors.white),
                              onChanged: (value) => height1 = value,
                              decoration: const InputDecoration(
                                labelText: "Height 1",
                                labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                errorStyle:
                                TextStyle(color: Colors.redAccent, fontSize: 15.0),
                              ),
                              validator: (value){
                                if (value == null || value.isEmpty)
                                {
                                  return "Please Enter Height 1";
                                }
                                return null;
                              },
                            )
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              autofocus: false,
                              initialValue: height2.toString(),
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.white,
                              style: const TextStyle(fontSize: 20.0,color: Colors.white),
                              onChanged: (value) => height2 = value,
                              decoration: const InputDecoration(
                                labelText: "Height 2",
                                labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                errorStyle:
                                TextStyle(color: Colors.redAccent, fontSize: 15.0),
                              ),
                              validator: (value){
                                if (value == null || value.isEmpty)
                                {
                                  return "Please Enter Height 2";
                                }
                                return null;
                              },
                            )
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              autofocus: false,
                              initialValue: width1.toString(),
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.white,
                              style: const TextStyle(fontSize: 20.0,color: Colors.white),
                              onChanged: (value) => width1 = value,
                              decoration: const InputDecoration(
                                labelText: "Width 1",
                                labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                errorStyle:
                                TextStyle(color: Colors.redAccent, fontSize: 15.0),
                              ),
                              validator: (value){
                                if (value == null || value.isEmpty)
                                {
                                  return "Please Enter Width 1";
                                }
                                return null;
                              },
                            )
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              autofocus: false,
                              initialValue: width2.toString(),
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.white,
                              style: const TextStyle(fontSize: 20.0,color: Colors.white),
                              onChanged: (value) => width2 = value,
                              decoration: const InputDecoration(
                                labelText: "Width 2",
                                labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                errorStyle:
                                TextStyle(color: Colors.redAccent, fontSize: 15.0),
                              ),
                              validator: (value){
                                if (value == null || value.isEmpty)
                                {
                                  return "Please Enter Width 2";
                                }
                                return null;
                              },
                            )
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              autofocus: false,
                              initialValue: cross1.toString(),
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.white,
                              style: const TextStyle(fontSize: 20.0,color: Colors.white),
                              onChanged: (value) => cross1 = value,
                              decoration: const InputDecoration(
                                labelText: "Cross 1",
                                labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                errorStyle:
                                TextStyle(color: Colors.redAccent, fontSize: 15.0),
                              ),
                              validator: (value){
                                if (value == null || value.isEmpty)
                                {
                                  return "Please Enter Cross 1";
                                }
                                return null;
                              },
                            )
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            child: TextFormField(
                              autofocus: false,
                              initialValue: cross2.toString(),
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.white,
                              style: const TextStyle(fontSize: 20.0,color: Colors.white),
                              onChanged: (value) => cross2 = value,
                              decoration: const InputDecoration(
                                labelText: "Cross 2",
                                labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                                errorStyle:
                                TextStyle(color: Colors.redAccent, fontSize: 15.0),
                              ),
                              validator: (value){
                                if (value == null || value.isEmpty)
                                {
                                  return "Please Enter Cross 2";
                                }
                                return null;
                              },
                            )
                        ),
                        Container(
                          child: Center(
                            child: ElevatedButton(
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  setState(() {
                                    updateUser(did,name,int.parse(mobile.toString()),address,selectedType.toString(),double.parse(height1.toString()),double.parse(height2.toString()),double.parse(width1.toString()),double.parse(width2.toString()),double.parse(cross1.toString()),double.parse(cross2.toString()));
                                    Navigator.pop(context);

                                  }
                                  );
                                }
                              },
                              child: Container(
                                width: 200,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.deepOrange,
                                ),
                                child: const Center(child: Text('Update Data',style: TextStyle(fontSize: 20,color: Colors.white))),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                }
                )
            ),
    )
    )
    );
  }

}