import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:brekete_connect/models/user.dart';
import 'package:brekete_connect/utils/routes.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SubmittedMediationsScreen extends StatefulWidget {
  @override
  _SubmittedMediationsScreenState createState() =>
      _SubmittedMediationsScreenState();
}

class _SubmittedMediationsScreenState extends State<SubmittedMediationsScreen> {
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
            'Requested Mediations',
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
                      .collection('mediations')
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
                            title: new Text(
                              data['subject'],
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 3,
                                ),
                                new Text('' + data['case_type']),
                                SizedBox(
                                  height: 5,
                                ),
                                new Text(
                                  data['firstPersonName'] +
                                      ' vs ' +
                                      data['secondPersonName'],
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w300),
                                ),
                                /* SizedBox(
                                  height: 5,
                                ),
                                new Text(
                                  data['secondPersonName'],
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w300),
                                ), */
                              ],
                            ),
                            /* trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                      data['date'].toString().substring(0, 10),
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
                            ), */
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
}
