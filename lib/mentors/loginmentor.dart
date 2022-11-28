import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meetx/mentors/homementor.dart';
import 'package:get/get.dart';
import '../homepage.dart';
import 'signupmentor.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreenMn extends StatefulWidget {
  @override
  _LoginScreenStateMn createState() => _LoginScreenStateMn();
}

class _LoginScreenStateMn extends State<LoginScreenMn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int _success = 1;
  String _userEmail = "";

  void _SignIn() async{
    final User? user = (await _auth.signInWithEmailAndPassword(email: nameController.text, password: passwordController.text
    )).user;
    if(user != null){
      setState(() {
        _success = 2;
        _userEmail = user.email!;
        Get.offAll(() => MentorHome(email: _userEmail));
      });
    }else{
      setState(() {
        _success = 3;
        Get.offAll(()=>LoginScreenMn());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Meet-X',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.white60),
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60,width: 2),
                      ),
                      labelText: 'User Name',
                      labelStyle: TextStyle(color: Colors.white60),
                      icon: Icon(
                        Icons.email,
                        color: Colors.white60,
                      )
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white60),
                  controller: passwordController,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white60,width: 2),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white60),
                      // fillColor: Colors.white60,
                      icon: Icon(
                        Icons.password,color: Colors.white60,
                      )
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text('Forgot Password',),
              ),
              Container(
                  height: 80,
                  padding: const EdgeInsets.fromLTRB(400, 20, 400, 0),
                  child: ButtonTheme(
                    minWidth: 500,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(
                              1, 42, 76, 1.0)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 30.0, horizontal: 150.0)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)))
                      ),
                      child: const Text('Login',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      onPressed: () {
                        _SignIn();
                        // _success == 2 ? Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StartupHome())) : print("Failed");
                      },
                    ),
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Does not have account?', style: TextStyle(color: Colors.white60),),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreenMn()));//signup screen
                    },
                  )
                ],
              ),

              Container(
                height: 80,
                padding: const EdgeInsets.fromLTRB(200, 20, 200, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white30),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)))
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Choices()));
                  },
                  child: const Text('GO TO HOME',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ))
      ,
    );

  }
}