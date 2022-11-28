import 'package:flutter/material.dart';
import 'package:meetx/startup/calendar.dart';
import '../homepage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class StartupHome extends StatefulWidget{
  final String email;
  const StartupHome({Key? key, required this.email}) : super(key:key);
  @override
  _StartupHomeState createState() => _StartupHomeState(mmail: this.email);
}

class _StartupHomeState extends State<StartupHome> {
  final String mmail;
  _StartupHomeState({Key? key, required this.mmail});

  void _signOut() async{
    _auth.signOut();
    print("Signed out successfully!");
    Get.offAll(()=>Choices());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(100),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Startup-Home',
                  style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent.withOpacity(0.6),
                    fontSize: 40,
                    // fontStyle: FontStyle.italic
                  ),
                ),
                Padding(padding: EdgeInsets.all(50)),
                Padding(
                  padding: EdgeInsets.all(50),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                            padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)))
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventCalendar(mail:this.mmail)));
                        },
                        child: const Text('Edit my schedule'),
                      )),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                            padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)))
                        ),
                        onPressed: () {
                          _signOut();
                        },
                        child: const Text('Log out'),
                      )),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
}