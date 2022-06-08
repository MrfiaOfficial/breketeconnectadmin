import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:brekete_connect/models/user.dart';
import 'package:brekete_connect/utils/routes.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UpdateComplaint extends StatefulWidget {
  final String complaintUid;
  final String currentComment;
  final String currentStatus;
  final String currentCase;
  const UpdateComplaint({
    Key key,
    this.complaintUid,
    this.currentComment,
    this.currentStatus,
    this.currentCase,
  }) : super(key: key);

  @override
  _UpdateComplaintState createState() => _UpdateComplaintState();
}

class _UpdateComplaintState extends State<UpdateComplaint> {
  List<String> _case = [
    'Family',
    'Government',
    'Corporate',
    'Business',
    'School',
    'Religion',
    'Individual',
    'Community',
    'Property Estate',
    'Others'
  ];

  List<String> _status = [
    'Approved',
    'In-Review',
    'Disapproved',
  ];

  String _selectedStatus;
  String _currentCase;
  final _comment = TextEditingController();

  GlobalKey<FormState> fKey = GlobalKey<FormState>();
  bool isLoading;

  @override
  void initState() {
    isLoading = false;
    _comment.text = widget.currentComment;
    _selectedStatus = widget.currentStatus;
    _currentCase = widget.currentCase;
    super.initState();
  }

  Future<bool> _updateComplaint(String complaintUid) async {
    try {
      Map<String, dynamic> complaintDataMap = {
        'status': _selectedStatus,
        'case_type': _currentCase,
        'comment': _comment.text,
      };
      await FirebaseFirestore.instance
          .collection('complaints')
          .doc(widget.complaintUid)
          .update(complaintDataMap);

      setState(() {
        _comment.text = "";
        // name.text = "";
      });
      Fluttertoast.showToast(
          msg: 'Complaint Successfully Updated!',
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
              'Update Complaint',
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

                        // CASE TYPE
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Case Type',
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
                              // child: DropdownButtonHideUnderline(
                              // child: ButtonTheme(
                              // alignedDropdown: true,
                              child: DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                    // hint: Text('Place                                                                          '), // Not necessary for Option 1
                                    value: _currentCase,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _currentCase = newValue;
                                      });
                                    },
                                    items: _case.map((location) {
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
                              child: Text("UPDATE COMPLAINT",
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
                                  await _updateComplaint(widget.complaintUid);
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
