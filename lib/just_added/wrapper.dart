import 'package:brekete_connect/pages/lib/Dashboard.dart';
import 'package:brekete_connect/pages/lib/authenticate_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:brekete_connect/models/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var currentUser = FirebaseAuth.instance.currentUser;
  bool _isSignedIn;

  @override
  void initState() {
    _getLoggedIn();
    super.initState();
  }

  _getLoggedIn() async {
    if (currentUser != null) {
      setState(() {
        _isSignedIn = true;
      });
    } else {
      setState(() {
        _isSignedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isSignedIn ? Dashboard() : AuthenticatePage();
  }
}
