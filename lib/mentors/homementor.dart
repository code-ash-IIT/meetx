import 'package:flutter/material.dart';
import 'package:meetx/mentors/calendar.dart';
import '../homepage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MentorHome extends StatefulWidget{
  final String email;
  const MentorHome({Key? key, required this.email}) : super(key:key);
  @override
  _MentorHomeState createState() => _MentorHomeState(mmail: this.email);
}

class _MentorHomeState extends State<MentorHome> {

  final String mmail;
  _MentorHomeState({Key? key, required this.mmail});

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
                const Text(
                  'Mentor HomePage',
                  style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.white60,
                    fontSize: 40,
                    // fontStyle: FontStyle.italic
                  ),
                ),
                Padding(padding: EdgeInsets.all(50)),
                Center(
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
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventCalendar(mail:this.mmail)));
                      },
                      child: const Text('Edit my schedule',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                ButtonTheme(
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
                    onPressed: () {
                      _signOut();
                    },
                    child: const Text('Log out',
                      style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
              ],
            )
        )
    );
  }
}