import 'package:flutter/material.dart';

class Choices extends StatefulWidget{
  @override
  _State createState() => _State();
}

class _State extends State<Choices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Meet-X Login'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: new ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ElevatedButton(
                        child: new Text('As Mentor'),
                        // color: Colors.lightGreen,
                        onPressed: () {/** */},
                      ),
                      ElevatedButton(
                        child: Text('As Incubator'),
                        // color: Colors.lightGreen,
                        onPressed: () {/** */},
                      ),
                      ElevatedButton(
                        child: Text('As Startup'),
                        // color: Colors.lightGreen,
                        onPressed: () {/** */},
                      ),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
}