import 'package:flutter/material.dart';
import 'package:political_tap_flutter/main.dart';
import 'package:political_tap_flutter/widgets/location_form.dart';

class Settings extends StatefulWidget 
{
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 0, 205),
        title: Text("Settings"),
      ),
      drawer: NavDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: LocationForm()
      )
    );
  }
}