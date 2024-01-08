import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:measurement/HomePage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage> {
  // Future<void> main() async{
  //   WidgetsFlutterBinding.ensureInitialized();
  //   SharedPreferences prefs =await SharedPreferences.getInstance();
  //   var email=prefs.getString("email");
  //   print(email);
  //   runApp(MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: email==null?LoginPage():const MyHomePage(),));
  // }
  bool _isObscure = true;
  String _password = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController tec1 = TextEditingController();
  TextEditingController tec2 = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var user = FirebaseAuth.instance.currentUser;
    TextFormField tf1 = TextFormField(controller:tec1,
      autofocus: false,
      cursorColor: Colors.white,
      style: const TextStyle(fontSize: 20.0,color: Colors.white),
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.person,color: Colors.white),
        labelText: "Email",
        labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
    );
    TextFormField tf2 = TextFormField(controller:tec2,
      autofocus: false,
      onChanged: (value) {
        _password = value;
      },
      obscureText: _isObscure,
      cursorColor: Colors.white,
      style: const TextStyle(fontSize: 20.0,color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,color: Colors.white
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
              if (!_isObscure) {
                tec2.text = _password;
              }
            });
          },
        ),
        labelText: "Password",
        labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),

        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),

      ),
    );

    if (user != null) {
      debugPrint(user.displayName);
      debugPrint(user.email);
      debugPrint(user.uid);
      debugPrint(user.emailVerified.toString());
    }
    return Scaffold(
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
        child:
        Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white,width: 2),shape:BoxShape.circle),
              child: const Icon(Icons.person,color: Colors.white,size: 120),
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.all(7),
                child: tf1
            ),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.all(7),
                child: tf2
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              padding: const EdgeInsets.all(7),
              child: ElevatedButton(onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: tec1.text, password: tec2.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
                  tec1.clear();
                  tec2.clear();

                }
                on FirebaseAuthException catch (error) {
                  Fluttertoast.showToast(
                      msg: error.code,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
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
                  child: const Center(child: Text('Log-In',style: TextStyle(fontSize: 20,color: Colors.white))),
                ),
            )
            ),
            Container(
              child: ElevatedButton(onPressed: ()
                async {
                  try {
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: tec1.text , password: tec2.text );
                    var user = FirebaseAuth.instance.currentUser;
                    if(user!=null)
                    {
                      await user.sendEmailVerification();
                      // tec1.clear();
                      // tec2.clear();
                    }
                    else
                    {
                      Fluttertoast.showToast(
                          msg: "Couldn't verify the email!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                  }
                  on FirebaseAuthException catch (error)
                  {
                    Fluttertoast.showToast(
                        msg: error.code,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Sign-Up',style: TextStyle(fontSize: 20,color: Colors.white)),
              )
            )
          ],
        ),
      ),
      ));
  }
}