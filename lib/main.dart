import 'package:flutter/material.dart';
import 'package:measurement/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:measurement/Splash.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initilization = Firebase.initializeApp();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(future: _initilization,builder: (context,snapshot){
      if(snapshot.hasError)
      {
        print("Somthing is Wrong");
      }
      if(snapshot.connectionState == ConnectionState.done){
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(

            primarySwatch: Colors.deepOrange,
          ),
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      }
      return CircularProgressIndicator();
    });
  }
}

