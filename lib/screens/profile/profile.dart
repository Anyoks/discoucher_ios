import 'package:discoucher/constants/strings.dart';
import 'package:discoucher/models/shared.dart';
import 'package:discoucher/screens/settings/user-avatar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, @required this.loggedInUser}) : super(key: key);
  final LoggedInUser loggedInUser;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarProfile,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(width: 15.0),
          buildUserAvatar(widget.loggedInUser),
        ],
      ),
    );
  }
}
