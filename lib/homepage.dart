import 'package:flutter/material.dart';
import 'startup/loginst.dart';
import 'mentors/loginmentor.dart';
import 'incubator/loginadmin.dart';

class Choices extends StatefulWidget{
  @override
  _State createState() => _State();
}

class _State extends State<Choices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(100),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Meet-X',
                  style: TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent.withOpacity(0.6),
                      fontSize: 40,
                      // fontStyle: FontStyle.italic
                  ),
                ),
                Padding(padding: EdgeInsets.all(50)),
                Text(
                    'Continue as . . .',
                  style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.6),
                    fontSize: 40,
                    fontStyle: FontStyle.italic
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(50),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: ElevatedButton(
                        child: const Text('As Mentor'),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                            padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)))
                        ),

                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreenMn()));
                        },
                      )),
                      Expanded(child: ElevatedButton(
                        child: Text('As Incubator'),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                            padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)))
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreenAd()));
                        },
                      )),
                      Expanded(child: ElevatedButton(
                        child: Text('As Startup'),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
                            padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)))
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreenSt()));
                        },
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