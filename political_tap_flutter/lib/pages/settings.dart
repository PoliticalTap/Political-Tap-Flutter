import 'package:flutter/material.dart';
import 'package:political_tap_flutter/main.dart';

class Settings extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 0, 205),
        title: Text("Settings"),
      ),
      drawer: NavDrawer(),
      body: Container(
        child: Text("Settings")
      )
    );
  }
}