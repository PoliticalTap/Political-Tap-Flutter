import 'package:flutter/material.dart';
import 'package:political_tap_flutter/pages/profile.dart';
import 'package:political_tap_flutter/pages/feed.dart';
import 'package:political_tap_flutter/pages/ballot.dart';
import 'package:political_tap_flutter/pages/settings.dart';
import 'package:political_tap_flutter/widgets/location_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

var initialRoute = "/init";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var zipCode = prefs.getString("userZip");
  if (zipCode != null)
  {
    initialRoute = "/ballot";
  }

  runApp(PoliticalTapApp());
}

class PoliticalTapApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: 
      {
        "/init": (context) => Initializer(),
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
  
class Initializer extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 0, 205),
        title: Text("Welcome"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: LocationForm(redirectFunction: () {
          print("redirecting...");
          Navigator.popAndPushNamed(context, "/ballot");
        })
      )
    );
  }
}