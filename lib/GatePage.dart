import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:measurement/AddPage.dart';
import 'package:measurement/DisplayPage.dart';
import 'package:measurement/HomePage.dart';

class Gate extends StatefulWidget{
  const Gate({super.key});
  @override
  State<StatefulWidget> createState() => _GateState();

}

class _GateState extends State<Gate>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Gate Page',style: TextStyle(color: Colors.white),textAlign: TextAlign.center),backgroundColor: Colors.deepOrangeAccent,),
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
          child: GridView.extent(
            primary: false,
            padding: const EdgeInsets.all(16),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: 200.0,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset("assets/Images/gate1.jpg")
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset("assets/Images/gate2.jpg")
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset("assets/Images/gate3.jpg")
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset("assets/Images/gate4.jpg")
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset("assets/Images/gate5.jpg")
              ),
              Container(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset("assets/Images/gate6.jpg")
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
            SpeedDialChild(
              child: const Icon(Icons.home,color: Colors.white),
              backgroundColor: Colors.deepOrangeAccent,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyHomePage())),
              label: 'Home Page',
              labelStyle: const TextStyle(fontWeight: FontWeight.w500,color: Colors.white),
              labelBackgroundColor: Colors.deepOrangeAccent,
            ),
          ],
        )
    );
  }

}