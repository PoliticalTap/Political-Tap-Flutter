import 'package:flutter/material.dart';
import 'package:political_tap_flutter/main.dart';

class Ballot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 18, 0, 205),
          title: Text("Ballot"),
        ),
        drawer: NavDrawer(),
        body: Container(
          child: GridView.count(crossAxisCount: 2,
            children: [
              Card(child: new InkWell(
                onTap: () => Navigator.pushNamed(context, "/profile"),
                child:Column(children: [
                  Expanded(child: Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Gov-Mike-DeWine.jpg/717px-Gov-Mike-DeWine.jpg")),
                  Text("Mike DeWine")
              ]))),
            ],
          )
        ),
      );
  }
}
