import 'dart:convert';
import 'package:political_tap_flutter/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:political_tap_flutter/models/candidate_bio.dart';
import 'package:tweet_ui/tweet_ui.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:http/http.dart' as http;
import 'package:tweet_ui/models/api/tweet.dart';

class ProfileTabController extends StatelessWidget 
{
  const ProfileTabController({
    Key key,
    @required this.candidateBio,
  }) : super(key: key);

  final CandidateBio candidateBio;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) 
        {
          return <Widget>
          [
            SliverAppBar(
              expandedHeight: 120.0,
              leading: Container(),
              floating: true,
              pinned: false,
              backgroundColor: Color.fromARGB(255, 18, 0, 205),
              flexibleSpace: FlexibleSpaceBar(background: ProfileTitle(name: candidateBio.name, profileImage: candidateBio.profileImage, politicalParty: candidateBio.politicalParty,))
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  tabs: 
                  [
                    Tab(child: Text("About", style: TextStyle(fontSize: 16))),
                    Tab(child: Text("Posts", style: TextStyle(fontSize: 16))),
                  ]
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: new TabBarView(
            children: 
            [
              ProfileInfo(
                birthDate: candidateBio.birthDate, 
                family: candidateBio.family, 
                gender: candidateBio.gender, 
                homeCity: candidateBio.homeCity, 
                homeState: candidateBio.homeState, 
                religion: candidateBio.religion,
              ),
              TweetList(candidateId: candidateBio.candidateId)
            ]
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate 
{
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) 
  {
    return new Container(
      color: Color.fromARGB(255, 18, 0, 205),
      child: CustomTabBar(Color.fromARGB(255, 221, 17, 17), _tabBar),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) 
  {
    return false;
  }
}

class ProfileTitle extends StatefulWidget 
{
  final String name;
  final ImageProvider profileImage;
  final String politicalParty;

  ProfileTitle({@required this.name, @required this.profileImage, @required this.politicalParty});

  @override
  _ProfileTitleState createState() => _ProfileTitleState();
}

class _ProfileTitleState extends State<ProfileTitle> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Container(
        color: Color.fromARGB(255, 18, 0, 205),
        padding: EdgeInsets.all(10),
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>
        [
          Container(
            child: CircleAvatar(
              backgroundImage: widget.profileImage,
              radius: 45.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
                Text(widget.politicalParty,style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfo extends StatefulWidget 
{
  final String birthDate;
  final String family;
  final String gender;
  final String homeCity;
  final String homeState;
  final String religion;

  ProfileInfo({@required this.birthDate, @required this.family, @required this.gender, @required this.homeCity, @required this.homeState, @required this.religion});

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: [
          Text("Birth-date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Divider(color: Colors.red, thickness: 3, height: 25),
          Text(widget.birthDate, style: TextStyle(fontSize: 16)),
          SizedBox(height: 30),
          
          Text("Family", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Divider(color: Colors.red, thickness: 3, height: 30),
          Text(widget.family, style: TextStyle(fontSize: 16)),
          SizedBox(height: 30),
          
          Text("Gender", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Divider(color: Colors.red, thickness: 3, height: 30),
          Text(widget.gender, style: TextStyle(fontSize: 16)),
          SizedBox(height: 30),
          
          Text("Home City", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Divider(color: Colors.red, thickness: 3, height: 30),
          Text(widget.homeCity + ", " + widget.homeState, style: TextStyle(fontSize: 16)),
          SizedBox(height: 30),
          
          Text("Religion", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Divider(color: Colors.red, thickness: 3, height: 30),
          Text(widget.religion, style: TextStyle(fontSize: 16)),
          SizedBox(height: 30)
        ],
      )
    );
  }
}

class TweetList extends StatefulWidget 
{
  final candidateId;

  TweetList({@required this.candidateId});

  Future<List<Tweet>> tweets;
  @override
  _TweetListState createState() => _TweetListState();
}

class _TweetListState extends State<TweetList> 
{
  Future<List<EmbeddedTweetView>> tweets;

  @override
  void initState() {
    super.initState();
    tweets = fetchCandidateTweets(widget.candidateId);
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

Future<List<EmbeddedTweetView>> fetchCandidateTweets(String candidateId) async 
{
  //fetches candidate bio data from API
  var params = {
    "candidate_id" : candidateId
  };

  Uri uri = Uri.https("political-tap.herokuapp.com", "getCandidateTweets", params);
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
        print(element);
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