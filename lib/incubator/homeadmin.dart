import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:meetx/incubator/gcalendar.dart';
import '../homepage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:duration_picker/duration_picker.dart';
import 'calendar.dart';
import 'scheduler.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class AdminHome extends StatefulWidget{
  final String email;
  const AdminHome({Key? key, required this.email}) : super(key:key);
  @override
  _AdminHomeState createState() => _AdminHomeState(mmail: this.email);

  static final now = DateTime.now();

  // final dropdownDatePicker = DropdownDatePicker(
  //   firstDate: ValidDate(year: now.year, month: now.month, day: now.day),
  //   lastDate: ValidDate(year: now.year+1, month: 12, day: 31),
  //   textStyle: TextStyle(fontWeight: FontWeight.bold),
  //   dropdownColor: Color.fromRGBO(
  //       0, 102, 255, 0.5725490196078431),
  //   dateHint: DateHint(year: 'YYYY', month: 'MM', day: 'DD'),
  //   ascending: false,
  // );
}

class _AdminHomeState extends State<AdminHome> {

  dynamic _startupEmail;
  dynamic _mentorEmail;
  final String mmail;
  _AdminHomeState({Key? key, required this.mmail});

  void _signOut() async{
    _auth.signOut();
    print("Signed out successfully!");
    Get.offAll(()=>Choices());
  }

  // String dropdownvalue1 = 'Select Startup';
  //
  // // List of items in our dropdown menu
  // var items1 = [
  //   'Select Startup',
  //   'ashutoshsh2002@gmail.com',
  // ];
  // String dropdownvalue2 = 'Select Mentor';
  //
  // // List of items in our dropdown menu
  // var items2 = [
  //   'Select Mentor',
  //   'chaetenya.2002@gmail.com',
  // ];

  // Duration _duration = const Duration(hours: 0, minutes: 0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Admin-Home',
                  style: TextStyle(fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(
                        255, 255, 255, 1.0),
                    fontSize: 40,
                    // fontStyle: FontStyle.italic
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.all(5),
                        leading: Icon(
                          Icons.email,
                          color: Color.fromRGBO(
                              255, 255, 255, 0.8666666666666667),
                        ),
                        title: TextField(
                          controller: TextEditingController(text: _mentorEmail),
                          onChanged: (dynamic value) {
                            _mentorEmail = value;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(
                                  255, 255, 255, 0.8666666666666667),
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Mentor's email",hintStyle: TextStyle(color: Color.fromRGBO(244, 244, 244, 1)),

                          ),
                        ),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.all(5),
                        leading: Icon(
                          Icons.email,
                          color: Color.fromRGBO(
                              253, 253, 253, 0.8666666666666667),
                        ),
                        title: TextField(
                          controller: TextEditingController(text: _startupEmail),
                          onChanged: (dynamic value) {
                            _startupEmail = value;
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(
                                  255, 255, 255, 0.8666666666666667),
                              fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Startup's email",hintStyle: TextStyle(color: Color.fromRGBO(244, 244, 244, 1)),
                          ),
                        ),
                      ),
                      // DropdownButton(
                      //
                      //   // Initial Value
                      //   value: dropdownvalue1,
                      //
                      //   // Down Arrow Icon
                      //   icon: const Icon(Icons.keyboard_arrow_down),
                      //
                      //   // Array list of items
                      //   items: items1.map((String items) {
                      //     return DropdownMenuItem(
                      //       value: items,
                      //       child: Text(items),
                      //     );
                      //   }).toList(),
                      //   // After selecting the desired option,it will
                      //   // change button value to selected value
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       dropdownvalue1 = newValue!;
                      //     });
                      //   },
                      // ),
                      //
                      // DropdownButton(
                      //
                      //   // Initial Value
                      //   value: dropdownvalue2,
                      //
                      //   // Down Arrow Icon
                      //   icon: const Icon(Icons.keyboard_arrow_down),
                      //
                      //   // Array list of items
                      //   items: items2.map((String items) {
                      //     return DropdownMenuItem(
                      //       value: items,
                      //       child: Text(items),
                      //     );
                      //   }).toList(),
                      //   // After selecting the desired option,it will
                      //   // change button value to selected value
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       dropdownvalue2 = newValue!;
                      //     });
                      //   },
                      // ),
                      // widget.dropdownDatePicker,
                      // ElevatedButton(
                      //   onPressed: () => setState(
                      //         () => (debugPrint('Check.')),
                      //   ),
                      //   child: const Text('Print current date.'),
                      // ),
                      // const SizedBox(
                      //   height: 40,
                      // ),
                      // Text('Select duration of meeting : '),
                      // DurationPicker(
                      //     onChange: (duration){
                      //       print(duration.toString());
                      //     },
                      //   snapToMins: 5.0,
                      // )
                      // Expanded(
                      //     child: DurationPicker(
                      //       duration: _duration,
                      //       onChange: (val) {
                      //         setState(() => _duration = val);
                      //       },
                      //       snapToMins: 5.0,
                      //     )),

                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                ButtonTheme(
                  minWidth: 500,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(
                            1, 42, 76, 1.0)),
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(244, 244, 244, 1)),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)))
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventCalendar(mentorMail:_mentorEmail,startupMail:_startupEmail, mail: this.mmail,)));
                    },
                    child: const Text('Look up schedule'),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                ButtonTheme(
                  minWidth: 500,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(
                            1, 42, 76, 1.0)),
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(244, 244, 244, 1)),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)))
                    ),
                    onPressed: () {
                      _signOut();
                    },
                    child: const Text('Log out'),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                ButtonTheme(
                  minWidth: 500,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(
                            1, 42, 76, 1.0)),
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(244, 244, 244, 1)),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)))
                    ),
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CalendarEvents()));
                    },
                    child: const Text('gCalender'),
                  ),
                ),

              ],
            )

        ),
    //     floatingActionButton: Builder(
    //       builder: (BuildContext context) => FloatingActionButton(
    //         onPressed: () async {
    //           var resultingDuration = await showDurationPicker(
    //           context: context,
    //           initialTime: Duration(minutes: 30),
    //         );
    //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //           content: Text('Chose duration: $resultingDuration')));
    //       },
    //       tooltip: 'Popup Duration Picker',
    //         child: Icon(Icons.add),
    // )),
    );
  }
}