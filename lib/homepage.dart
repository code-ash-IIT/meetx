import 'package:flutter/material.dart';
import 'startup/loginst.dart';
import 'mentors/loginmentor.dart';
import 'incubator/loginadmin.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Choices extends StatefulWidget{
  @override
  _State createState() => _State();
}

class _State extends State<Choices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Padding(
              padding: EdgeInsets.all(100),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Text(
                    'Meet-X',
                    style: TextStyle(fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 60,
                        // fontStyle: FontStyle.italic
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(50)),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('Continue as . . . . .',
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white60)),
                    ],
                    onTap: () {
                      print("I am executing");
                    },
                  ),

                  Padding(padding: EdgeInsets.all(10)),
                  ButtonTheme(
                    minWidth: 500.0,
                    // height: 50.0,
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreenMn()));
                      },
                      child: const Text('As Mentor',
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(10)),
                  ButtonTheme(
                    minWidth: 500.0,
                    // height: 50.0,
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreenAd()));
                      },
                      child: const Text('As Incubator',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),


                  Padding(padding: EdgeInsets.all(10)),


                  ButtonTheme(
                    minWidth: 500.0,
                    // height: 50.0,
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
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreenSt()));
                      },
                      child: const Text('As Startup',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),

                ],
              )
          ),
        )
    );
  }
}