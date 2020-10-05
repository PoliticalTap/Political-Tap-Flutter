import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color.fromARGB(255, 18, 0, 205),
        elevation: 0,
      ),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            color: Color.fromARGB(255, 18, 0, 205),
            padding: EdgeInsets.all(10),
            child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Gov-Mike-DeWine.jpg/717px-Gov-Mike-DeWine.jpg"),
                  radius: 40.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mike DeWine",
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                    Text("Governor of Ohio",style: TextStyle(color: Colors.white),),
                    Text("Republican",style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ],
          ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "[Insert Bio]",
              ),
            ),
          )
        ]),
      ),
    );
  }
}