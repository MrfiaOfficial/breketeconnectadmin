import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:brekete_connect/models/user.dart';
import 'package:brekete_connect/utils/routes.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UpdateAppointment extends StatefulWidget {
  final String appointmentUid;
  final String currentComment;
  final String currentStatus;
  final String currentDate;
  final String currentTime;
  const UpdateAppointment({
    Key key,
    this.appointmentUid,
    this.currentComment,
    this.currentStatus,
    this.currentDate,
    this.currentTime,
  }) : super(key: key);

  @override
  _UpdateAppointmentState createState() => _UpdateAppointmentState();
}

class _UpdateAppointmentState extends State<UpdateAppointment> {
  List<String> _status = [
    'Approved',
    'In-Review',
    'Disapproved',
  ];

  String _formattedDate;
  String _formattedTime;
  String _selectedStatus;
  String _currentComment;
  String _currentDate;
  String _currentTime;
  String timef;
  String vot;
  final time = TextEditingController();
  final _comment = TextEditingController();

  GlobalKey<FormState> fKey = GlobalKey<FormState>();

  DateTime selectedDate; // = DateTime.now();
  TimeOfDay selectedTime; // = TimeOfDay.now();
  bool isLoading;

  @override
  void initState() {
    isLoading = false;
    _comment.text = widget.currentComment;
    _selectedStatus = widget.currentStatus;
    _currentDate = widget.currentDate;
    _currentTime = widget.currentTime;
    vot = widget.currentTime;
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(widget.currentDate),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.red,
            accentColor: Colors.red,
            colorScheme: ColorScheme.light(primary: Colors.red),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _formattedDate = selectedDate.toLocal().toString().split(' ')[0];
        _currentDate = _formattedDate;
      });
    /* else {
      setState(() {
        _formattedDate = _currentDate.toString().substring(0, 10);
      });
    } */
    /* if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _formattedDate = selectedDate.toLocal().toString().split(' ')[0];
      });
    if (picked = null) {
      setState(() {
        _formattedDate = _currentDate.toString().substring(0, 10);
      });
    } */
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child,
          );
        });

    if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
        timef = selectedTime.toString();
        vot = timef.substring(10, 15);
        _formattedTime = selectedTime.toString().substring(10, 15);
        _currentTime = _formattedTime;
      });
    /* else {
      setState(() {
        _formattedTime = _currentTime;
      });
    } */

    /* if (picked_s != null && picked_s != selectedTime)
      setState(() {
        selectedTime = picked_s;
        timef = selectedTime.toString();
        vot = timef.substring(10, 15);
        _formattedTime = selectedTime.toString().substring(10, 15);
      });
    if (picked_s = null) {
      setState(() {
        _formattedTime = _currentTime;
      });
    } */
  }

  Future<bool> _updateAppointment(String appointmentUid) async {
    try {
      Map<String, dynamic> appointmentDataMap = {
        'created_at': Timestamp.now(),
        'creater_id': CurrentAppUser.currentUserData.userId,
        "date": _currentDate,
        "time": _currentTime,
        'status': _selectedStatus,
        'comment': _comment.text,
      };
      await FirebaseFirestore.instance
          .collection('Booked_Appointment')
          .doc(appointmentUid)
          .update(appointmentDataMap);

      setState(() {
        _comment.text = "";
        // name.text = "";
      });
      Fluttertoast.showToast(
          msg: 'Appointment Successfully Updated!',
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.TOP);
      AppRoutes.pop(context);
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong!');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.blueGrey.shade200,
        dialogBackgroundColor: Colors.blueGrey.shade200,
      ),
      home: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
                onTap: () {
                  AppRoutes.pop(context);
                },
                child: Icon(Icons.arrow_back_ios, color: Colors.black)),
            title: Text(
              'Book Appointment',
              style: TextStyle(
                color: Color.fromARGB(255, 49, 76, 190),
              ),
            ),
          ),
          body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/newsbg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, height * 0.081, 30, 0),
                child: SingleChildScrollView(
                  child: Form(
                    key: fKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              'BOOK APPOINTMENT',
                              style: TextStyle(
                                color: Color.fromARGB(255, 49, 76, 190),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        /* SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          'Fill the form below to Book an appointment  with the ordinary President before coming  to the office ',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        ), */

                        // STATUS
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              height: height * 0.05,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                  color: Color(0XFFEFF3F6),
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.1),
                                        offset: Offset(6, 2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0),
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.9),
                                        offset: Offset(-6, -2),
                                        blurRadius: 6.0,
                                        spreadRadius: 3.0)
                                  ]),
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                    // hint: Text('Place                                                                          '), // Not necessary for Option 1
                                    value: _selectedStatus,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedStatus = newValue;
                                      });
                                    },
                                    items: _status.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // DATE
                        SizedBox(
                          height: height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            width: width,
                            // height: ,
                            child: Text(
                              selectedDate == null
                                  ? _currentDate.toString().substring(0, 10)
                                  : _formattedDate,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),

                        // TIME
                        SizedBox(
                          height: height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: Container(
                            width: width,
                            child: Text(
                              selectedTime == null
                                  ? _currentTime
                                  : _formattedTime,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),

                        // COMMENT
                        SizedBox(
                          height: height * 0.03,
                        ),
                        SizedBox(
                          child: Container(
                            // width: width,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 4,
                                      offset: Offset(1, 1))
                                ]),
                            child: TextFormField(
                              controller: _comment,
                              // minLines: 5,
                              maxLines: 7,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: 'Admin\'s Comment',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        // UPDATE BUTTON
                        SizedBox(
                          height: height * 0.04,
                        ),
                        Container(
                          height: height * 0.06,
                          child: ElevatedButton(
                              child: Text("UPDATE APPOINTMENT",
                                  style: TextStyle(fontSize: 20)),
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          side:
                                              BorderSide(color: Colors.red)))),
                              onPressed: () async {
                                if (fKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await _updateAppointment(
                                      widget.appointmentUid);
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }),
                        ),

                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
