import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tweet_ui/tweet_ui.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:http/http.dart' as http;
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedTweetList extends StatefulWidget 
{
  FeedTweetList();

  Future<List<Tweet>> tweets;
  @override
  _FeedTweetListState createState() => _FeedTweetListState();
}

class _FeedTweetListState extends State<FeedTweetList> 
{
  Future<List<EmbeddedTweetView>> tweets;

  @override
  void initState() {
    super.initState();
    tweets = fetchFeed();
  }

  @override
  Widget build(BuildContext context) 
  {
    
    return FutureBuilder<List<EmbeddedTweetView>>(
        future: tweets,
        builder: (context, snapshot) 
        {
          if (snapshot.hasData) 
          {
            return ListView(children: snapshot.data);
          } 
          else if (snapshot.hasError) 
          {
            return Center(child: Text("${snapshot.error}", style: TextStyle(fontSize: 20) ));
          }

          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      );
  }
}

Future<List<EmbeddedTweetView>> fetchFeed() async 
{
  final prefs = await SharedPreferences.getInstance();

  // Try reading data from the counter key. If it doesn't exist, return 0.
  final zipCode = prefs.getString('userZip') ?? "0";

  //fetches feed from location
  var params = {
    "zip" : zipCode
  };

  Uri uri = Uri.https("political-tap.herokuapp.com", "getFeedFromLocation", params);
  final response = await http.get(uri);

  if (response.statusCode == 200) 
  {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    String body = response.body;
    final data = jsonDecode(body);

    // Throw exception if there is an error in the backend
    if (data.containsKey("error"))
    {
      throw Exception(data["error"]);
    }

    List<EmbeddedTweetView> tweets = [];

    data["tweets"].forEach((element) 
      {
        tweets.add(EmbeddedTweetView.fromTweet(Tweet.fromJson(element)));
      }
    );

    return tweets;
  } 
  else 
  {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load candidate tweets');
  }
}