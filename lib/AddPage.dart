import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:measurement/DisplayPage.dart';
import 'package:measurement/HomePage.dart';

class AddData extends StatefulWidget{
  const AddData({super.key});
  @override
  State<StatefulWidget> createState() => _AddDataState();

}

class _AddDataState extends State<AddData> {
  final _formKey = GlobalKey<FormState>();
  var name ="";
  late num mobile;
  var address="";
  late num height1;
  late num height2;
  late num width1;
  late num width2;
  late num cross1;
  late num cross2;
  var selectedType;
  final List<String> _itemstype = <String>[
    'Door',
    'Window',
    'Gate'
  ];

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final height1Controller = TextEditingController();
  final height2Controller = TextEditingController();
  final width1Controller = TextEditingController();
  final width2Controller = TextEditingController();
  final cross1Controller = TextEditingController();
  final cross2Controller = TextEditingController();

  @override
  void dispose(){
    nameController.dispose();
    mobileController.dispose();
    addressController.dispose();
    height1Controller.dispose();
    height2Controller.dispose();
    width1Controller.dispose();
    width2Controller.dispose();
    cross1Controller.dispose();
    cross2Controller.dispose();
    super.dispose();
  }
  clearText(){
    nameController.clear();
    mobileController.clear();
    addressController.clear();
    height1Controller.clear();
    height2Controller.clear();
    width1Controller.clear();
    width2Controller.clear();
    cross1Controller.clear();
    cross2Controller.clear();
    selectedType.clear();
  }

  CollectionReference customers = FirebaseFirestore.instance.collection('Customerdetails');
  Future<void>addUser(){
    return customers.add({'Name':name,'MobileNo':mobile,'Address':address,'ItemType':selectedType,'Height1':height1,'Height2':height1,'Width1':width1,'Width2':width2,'Cross1':cross1,'Cross2':cross2}).then((value)=>Fluttertoast.showToast(
    msg: "Add User",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0
    )).catchError((error) => Fluttertoast.showToast(
        msg: "Faild to Add User:$error",
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
            'Add Data Page', style: TextStyle(color: Colors.white),
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
            child: ListView(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    cursorColor: Colors.white,
                    style: const TextStyle(fontSize: 20.0,color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    ),
                    controller: nameController,
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
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    style: const TextStyle(fontSize: 20.0,color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Mobile No.",
                      labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,)),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    ),
                    controller: mobileController,
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
                    cursorColor: Colors.white,
                    style: const TextStyle(fontSize: 20.0,color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Address",
                      labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    ),
                    controller: addressController,
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
                  hint: Text('Choose Item Type', style: TextStyle(color: Colors.white,fontSize: 18),),
                )
                ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    style: const TextStyle(fontSize: 20.0,color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Height 1",
                      labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    ),
                    controller: height1Controller,
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
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    style: const TextStyle(fontSize: 20.0,color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Height 2",
                      labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    ),
                    controller: height2Controller,
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
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    style: const TextStyle(fontSize: 20.0,color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Width 1",
                      labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    ),
                    controller: width1Controller,
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
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    style: const TextStyle(fontSize: 20.0,color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Width 2",
                      labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    ),
                    controller: width2Controller,
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
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    style: const TextStyle(fontSize: 20.0,color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Cross 1",
                      labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    ),
                    controller: cross1Controller,
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
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    style: const TextStyle(fontSize: 20.0,color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Cross 2",
                      labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 15.0),
                    ),
                    controller: cross2Controller,
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
                          name = nameController.text;
                          mobile = int.parse(mobileController.text);
                          address = addressController.text;
                          height1 = double.parse(height1Controller.text);
                          height2 = double.parse(height2Controller.text);
                          width1 = double.parse(width1Controller.text);
                          width2 = double.parse(width2Controller.text);
                          cross1 = double.parse(cross1Controller.text);
                          cross2 = double.parse(cross2Controller.text);
                          selectedType.toString();
                          addUser();
                          clearText();

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
                      child: const Center(child: Text('Add Data',style: TextStyle(fontSize: 20,color: Colors.white))),
                    ),
                  ),
                ),
              ),
            ],
            )
            )
          ),
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
              child: const Icon(Icons.home,color: Colors.white),
              backgroundColor: Colors.deepOrangeAccent,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyHomePage())),
              label: 'Home Page',
              labelStyle: const TextStyle(fontWeight: FontWeight.w500,color: Colors.white),
              labelBackgroundColor: Colors.deepOrangeAccent,
            ),
            SpeedDialChild(
              child: const Icon(Icons.dataset,color: Colors.white),
              backgroundColor: Colors.deepOrangeAccent,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const DisplayData())),
              label: 'Display Data',
              labelStyle: const TextStyle(fontWeight: FontWeight.w500,color: Colors.white),
              labelBackgroundColor: Colors.deepOrangeAccent,
            ),
          ],
        ),
    );
  }
}