import 'package:brekete_connect/pages/lib/appointment/update_appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:brekete_connect/models/user.dart';
import 'package:brekete_connect/utils/routes.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BookedAppointments extends StatefulWidget {
  @override
  _BookedAppointmentsState createState() => _BookedAppointmentsState();
}

class _BookedAppointmentsState extends State<BookedAppointments> {
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
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                AppRoutes.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.black)),
          title: Text(
            'Booked Appointments',
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
                padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Booked_Appointment')
                      .orderBy('created_at', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return new ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return Card(
                          child: new ListTile(
                            onTap: () {
                              AppRoutes.push(context, UpdateAppointment());
                            },
                            title: new Text(data['name'],
                                style: TextStyle(color: Colors.blue)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 3,
                                ),
                                new Text('' + data['phone']),
                                SizedBox(
                                  height: 5,
                                ),
                                new Text(
                                  data['description'],
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(height: 5),
                                new Text(
                                  '____________',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(height: 5),
                                new Text(
                                  'Status: ' +
                                      '${data['status'] ?? 'In-Review'}',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(height: 5),
                                new Text(
                                  'Admin\'s Comment: ' +
                                      '${data['comment'] ?? ''}',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                          data['date']
                                              .toString()
                                              .substring(0, 10),
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w300)),
                                    ),
                                    Container(
                                      child: Text(data['time'],
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w300)),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  alignment: Alignment.topCenter,
                                  color: Colors.red,
                                  onPressed: () => deleteAppointment(
                                      appointmentUid: document.id),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                )),
          ),
        ),
      ),
    );
  }

  Future<void> deleteAppointment({String appointmentUid}) async {
    DocumentReference documentReferencer = FirebaseFirestore.instance
        .collection('Booked_Appointment')
        .doc(appointmentUid);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Appointment deleted successfully'))
        .catchError((e) => print(e));
  }
}
