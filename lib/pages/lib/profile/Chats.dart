import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brekete_connect/helper/helper_functions.dart';
import 'package:brekete_connect/models/user.dart';
import 'package:brekete_connect/pages/chat_page.dart';
import 'package:brekete_connect/pages/lib/Dashboard.dart';
import 'package:brekete_connect/pages/lib/chat/chat_screen.dart';
import 'package:brekete_connect/pages/lib/chat/friends.dart';
import 'package:brekete_connect/pages/lib/chat/groupchat/gchat_screen.dart';
import 'package:brekete_connect/pages/lib/profile/edit_profile.dart';
import 'package:brekete_connect/pages/lib/profile/user_profile.dart';
import 'package:brekete_connect/pages/lib/signin_page.dart';
import 'package:brekete_connect/utils/routes.dart';
import '../GroupChat.dart';

class Chats extends StatefulWidget {
  const Chats({Key key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  String _userName = '';
  String _email = '';
  String _userLoggedIn = null;

  //
  @override
  void initState() {
    CurrentAppUser.currentUserData.getUserData().then((value) {
      setState(() {
        _userLoggedIn != null;
      });
    });
    /* setState(() {
      _userLoggedIn != null;
    }); */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    //String _userLoggedIn = CurrentAppUser.currentUserData.userId;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.blueGrey.shade200,
        dialogBackgroundColor: Colors.blueGrey.shade200,
      ),
      home: Scaffold(
        /* appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                AppRoutes.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.black)),
          title: Text(
            'Account',
            style: TextStyle(
              color: Color.fromARGB(255, 49, 76, 190),
            ),
          ),
        ), */
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/chatsbg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: height * .225,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.07,
                        ),
                        CurrentAppUser.currentUserData.photo == ""
                            ? Icon(
                                Icons.account_circle_rounded,
                                color: Colors.white,
                                size: 90.0,
                              )
                            : Container(
                                height: 75,
                                width: 75,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        CurrentAppUser.currentUserData.photo,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Container(
                      height: height * 0.4,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.1,
                                    ),
                                    Image.asset(
                                      'assets/user.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    SizedBox(
                                      width: width * 0.1,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyProfile()));
                                      },
                                      child: Text(
                                        'My Profile',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 49, 76, 190),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                /*SizedBox(
                                height: height * 0.025,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.1,
                                  ),
                                  Image.asset(
                                    'assets/messages1.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                  SizedBox(
                                    width: width * 0.1,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                    currentuser: CurrentAppUser
                                                        .currentUserData,
                                                  )));
                                    },
                                    child: Text(
                                      'Messages',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 49, 76, 190),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.025,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.1,
                                  ),
                                  Image.asset(
                                    'assets/friends.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                  SizedBox(
                                    width: width * 0.1,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (context) => FriendsScreen(
                                                    currentuser: CurrentAppUser
                                                        .currentUserData,
                                                  )));
                                    },
                                    child: Text(
                                      'Friends',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 49, 76, 190),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.025,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.1,
                                  ),
                                  Image.asset(
                                    'assets/groups.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                  SizedBox(
                                    width: width * 0.1,
                                  ),
                                  InkWell(
                                    // This was previously on available group chat
                                    // onTap: () {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) => GroupChat(),
                                    //       ));
                                    // },
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GroupChatScreen(
                                                    currentuser: CurrentAppUser
                                                        .currentUserData,
                                                  )));
                                    },
                                    child: Text(
                                      'Groups',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 49, 76, 190),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ), */
                                SizedBox(
                                  height: height * 0.025,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.1,
                                    ),
                                    Image.asset(
                                      'assets/settings.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    SizedBox(
                                      width: width * 0.1,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfile()));
                                      },
                                      child: Text(
                                        'Settings',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 49, 76, 190),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.025,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print('::::::::::::::::::::::');
                                    HelperFunctions.logout();
                                    AppRoutes.makeFirst(context, SignInPage());
                                    setState(() {
                                      _userLoggedIn = null;
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.1,
                                      ),
                                      Image.asset(
                                        'assets/logout.png',
                                        height: 40,
                                        width: 40,
                                      ),
                                      SizedBox(
                                        width: width * 0.1,
                                      ),
                                      Text(
                                        'Logout',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 49, 76, 190),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                  child: IconButton(
                    onPressed: () {
                      AppRoutes.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
