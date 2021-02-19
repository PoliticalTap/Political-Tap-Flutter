import 'package:flutter/material.dart';
import 'package:political_tap_flutter/main.dart';
import 'package:political_tap_flutter/widgets/feed_widgets.dart';

class Feed extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 0, 205),
        title: Text("Feed"),
      ),
      drawer: NavDrawer(),
      body: Container(
        child: FeedTweetList()
      ),
    );
  }
}
