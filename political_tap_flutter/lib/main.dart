import 'package:flutter/material.dart';
import 'package:political_tap_flutter/pages/profile.dart';
import 'package:political_tap_flutter/pages/feed.dart';
import 'package:political_tap_flutter/pages/ballot.dart';
import 'package:political_tap_flutter/pages/settings.dart';

void main() 
{
  runApp(PoliticalTapApp());
}

class PoliticalTapApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      initialRoute: "/",
      routes: 
      {
        "/": (context) => Ballot(),
        "/feed": (context) => Feed(),
        "/ballot": (context) => Ballot(),
        "/settings": (context) => Settings(),
        "/profile": (context) => Profile(),
      },
    );
  }
}

class NavDrawer extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return Drawer(
      child: ListView(
        children: 
        [
          ListTile(
            title: Text("Feed"),
            onTap: () 
            {
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, "/feed");
            },
          ),
          ListTile(
            title: Text("Ballot"),
            onTap: () 
            {
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, "/ballot");
            },
          ),
          ListTile(
            title: Text("Settings"),
            onTap: () 
            {
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, "/settings");
            },
          ),
        ],
      )
    );
  }
}