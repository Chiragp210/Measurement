import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:measurement/AddPage.dart';
import 'package:measurement/DisplayPage.dart';
import 'package:measurement/DoorPage.dart';
import 'package:measurement/GatePage.dart';
import 'package:measurement/Login.dart';
import 'package:measurement/WindowPage.dart';

class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key});
  @override
  State<StatefulWidget> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage>{
  final FirebaseAuth auth = FirebaseAuth.instance;
  signout() async{
    await auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home Page',style: TextStyle(color: Colors.white),textAlign: TextAlign.center),backgroundColor: Colors.deepOrangeAccent,),
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
       child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
               margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Door()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 230,
                    child: Image.asset("assets/Images/dooricon.jpg",fit: BoxFit.cover,),

                  ),
                  const Text("Doors",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
                  const SizedBox(height: 10)
                ],
              )
            )
           ),
           Container(
               margin: const EdgeInsets.symmetric(vertical: 5.0),
               child: GestureDetector(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> const Window()));
                 },
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     SizedBox(
                       width: 200,
                       height: 200,
                       child: Image.asset("assets/Images/windowicon.jpg",fit: BoxFit.cover,),

                     ),
                     const Text("Windows",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
                     const SizedBox(height: 10)
                   ],
                 )
               )
           ),
           Container(
               margin: const EdgeInsets.symmetric(vertical: 5.0),
               child: GestureDetector(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> const Gate()));
                 },
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     SizedBox(
                       width: 300,
                       height: 200,
                       child: Image.asset("assets/Images/gate1.jpg",fit: BoxFit.cover,),

                     ),
                     const Text("Gates",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
                     const SizedBox(height: 10)
                   ],
                 )
               )
           ),
         ],
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
           child: const Icon(Icons.add,color: Colors.white),
           backgroundColor: Colors.deepOrangeAccent,
           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddData())),
           label: 'Add Data',
           labelStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),
           labelBackgroundColor: Colors.deepOrangeAccent,
         ),
         SpeedDialChild(
           child: const Icon(Icons.dataset,color: Colors.white),
           backgroundColor: Colors.deepOrangeAccent,
           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const DisplayData())),
           label: 'Display Data',
           labelStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),
           labelBackgroundColor: Colors.deepOrangeAccent,
         ),
         SpeedDialChild(
           child: const Icon(Icons.logout,color: Colors.white),
           backgroundColor: Colors.deepOrangeAccent,
           onTap: () => signout(),
           label: 'Logout',
           labelStyle: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),
           labelBackgroundColor: Colors.deepOrangeAccent,
         ),
       ],
     )
    );
  }

}