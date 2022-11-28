import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'loginmentor.dart';
import '../homepage.dart';
import 'homementor.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupScreenMn extends StatefulWidget {
  @override
  _SignupScreenStateMn createState() => _SignupScreenStateMn();
}

class _SignupScreenStateMn extends State<SignupScreenMn> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool _success;
  late String _userEmail;

  void _register() async{
    final User? user = (
        await _auth.createUserWithEmailAndPassword(email: nameController.text, password: passwordController.text)).user;
    if(user != null){
      setState(() {
        _success = true;
        _userEmail = user.email!;
      });
    } else{
      setState(() {
        _success=false;
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
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.w900,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign up',
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                  height: 70,
                  padding: const EdgeInsets.fromLTRB(400, 20, 400, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)))
                    ),
                    child: const Text('Sign-up'),
                    onPressed: () async{
                      _register();
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StartupHome()));//signup screen
                      print(nameController.text);
                      print(passwordController.text);
                    },
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Already have an account?'),
                  TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreenMn()));//signup screen
                    },
                  )
                ],
              ),

              Container(
                height: 80,
                padding: const EdgeInsets.fromLTRB(200, 20, 200, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white30),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)))
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Choices()));
                  },
                  child: Text('GO TO HOME'),
                ),
              ),
            ],
          ))
      ,
    );

  }
}