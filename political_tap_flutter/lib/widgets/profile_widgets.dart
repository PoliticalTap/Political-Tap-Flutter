import 'dart:convert';
import 'package:political_tap_flutter/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:political_tap_flutter/models/candidate_bio.dart';
import 'package:tweet_ui/tweet_ui.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:http/http.dart' as http;
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
      length: 3,
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
                    Tab(child: Text("Votes", style: TextStyle(fontSize: 16))),
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
                candidateId: candidateBio.candidateId,
                birthDate: candidateBio.birthDate, 
                family: candidateBio.family, 
                gender: candidateBio.gender, 
                homeCity: candidateBio.homeCity, 
                homeState: candidateBio.homeState, 
                religion: candidateBio.religion,
                education: candidateBio.education,
                office: candidateBio.office,
                orgMembership: candidateBio.orgMembership,
                political: candidateBio.political,
                profession: candidateBio.profession
              ),
              TweetList(candidateId: candidateBio.candidateId),
              VoteList(candidateId: candidateBio.candidateId)
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
  final String candidateId;
  final String birthDate;
  final String family;
  final String gender;
  final String homeCity;
  final String homeState;
  final String religion;
  final List<String> education;
  final List<String> office;
  final List<String> orgMembership;
  final List<String> political;
  final List<String> profession;

  ProfileInfo({@required this.candidateId, @required this.birthDate, @required this.family, @required this.gender, @required this.homeCity, @required this.homeState, 
  @required this.religion, @required this.education, @required this.office, @required this.orgMembership, @required this.political, @required this.profession});

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
          Text("Birthdate", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
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
          SizedBox(height: 30),

          Text("Education", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Divider(color: Colors.red, thickness: 3, height: 30),
          // Text(widget.education[0], style: TextStyle(fontSize: 16)),
          getTextWidgets(widget.education),
          SizedBox(height: 30),

          Text("Office", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Divider(color: Colors.red, thickness: 3, height: 30),
          // Text(widget.office[0], style: TextStyle(fontSize: 16)),
          getTextWidgets(widget.office, bulletPoints: false),
          SizedBox(height: 30),

          Text("Organization Membership", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Divider(color: Colors.red, thickness: 3, height: 30),
          // Text(widget.orgMembership[0], style: TextStyle(fontSize: 16)),
          getTextWidgets(widget.orgMembership),
          SizedBox(height: 30),

          Text("Political Experience", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Divider(color: Colors.red, thickness: 3, height: 30),
          // Text(widget.political[0], style: TextStyle(fontSize: 16)),
          getTextWidgets(widget.political),
          SizedBox(height: 30),

          Text("Professional Experience", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Divider(color: Colors.red, thickness: 3, height: 30),
          // Text(widget.profession[0], style: TextStyle(fontSize: 16)),
          getTextWidgets(widget.profession),
          SizedBox(height: 30),

          Text("Social Media Links", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Divider(color: Colors.red, thickness: 3, height: 30),
          SocialMediaSection(candidateId: widget.candidateId),
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
            return Center(child: Text("${snapshot.error}", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,));
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

Widget getTextWidgets(List<String> strings, {bool bulletPoints = true})
{
  return new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: strings.map((item) {
      if (item != "No information available" && bulletPoints)
      {
        item = "\u2022   " + item;
      }
      return new Text(item, style: TextStyle(fontSize: 16));
    }).toList()
  );
}

class VoteList extends StatefulWidget 
{
  final candidateId;
  Future<List<Map<String, dynamic>>> voteResponse;

  VoteList({@required this.candidateId})
  {
    voteResponse = fetchVoteHistory(candidateId);
  }

  @override
  _VoteListState createState() => _VoteListState();
}

class _VoteListState extends State<VoteList> 
{

  @override
  Widget build(BuildContext context) 
  {
    return FutureBuilder(
      future: widget.voteResponse,
      builder: (context, snapshot) {
        if (snapshot.hasData)
        {
          List<Map<String, dynamic>> response = snapshot.data;
          int length = response.length;

          if (length == 0)
          {
            return Center(child: Text("Vote history not available"));
          }

          final voteColors = 
          {
            //green
            "Yes" : Color.fromARGB(255, 51, 153, 0),

            //light blue
            "Sponsor" : Color.fromARGB(255, 102, 153, 204),
            "Co-Sponsor" : Color.fromARGB(255, 102, 153, 204),

            //red
            "No" : Color.fromARGB(255, 221, 17, 17),
            
            //gold
            "Did Not Vote" : Color.fromARGB(255, 204, 153, 0),

            //white
            "Unknown Vote" : Color.fromARGB(255, 153, 153, 153)
          };

          return ListView.separated
          (
            itemCount: length,
            itemBuilder: (BuildContext context, int index)
            {
              Map<String, dynamic> vote = response[index];
              Color voteColor = voteColors[vote["vote"]];
              
              return new ListTile(
               title: Text(vote["billNumber"]),
               subtitle: Text(vote["billTitle"] + "\nStage:" + vote["stage"]),
               trailing: SizedBox(
                 width: 60,
                 child: Text(vote["vote"], style: TextStyle(color: voteColor, fontWeight: FontWeight.bold))),
              );

            },
            separatorBuilder: (context, builder)
            {
              return Divider(thickness: 2);
            });
        }
        else if (snapshot.hasError) 
        {
          return Center(child: Text("${snapshot.error}", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,));
        }

        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      }); 
  }
}

Future<List<Map<String, dynamic>>> fetchVoteHistory(String candidateId) async 
{
  //fetches candidate bio data from API
  var params = {
    "candidate_id" : candidateId
  };

  Uri uri = Uri.https("political-tap.herokuapp.com", "getCandidateVoteHistory", params);
  final response = await http.get(uri);

  if (response.statusCode == 200) 
  {
    String body = response.body;
    final data = (jsonDecode(body)as List).map((e) => e as Map<String, dynamic>)?.toList();

    return data;
  } 
  else 
  {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load candidate vote history');
  }
}

class SocialMediaSection extends StatefulWidget 
{
  final candidateId;
  Future<Map<String, dynamic>> socialMediaResponse;

  SocialMediaSection({@required this.candidateId})
  {
    socialMediaResponse = fetchSocialMediaLinks(candidateId);
  }

  @override
  _SocialMediaSectionState createState() => _SocialMediaSectionState();
}

class _SocialMediaSectionState extends State<SocialMediaSection> 
{

  @override
  Widget build(BuildContext context) 
  {
    return FutureBuilder(
      future: widget.socialMediaResponse,
      builder: (context, snapshot) {
        if (snapshot.hasData)
        {
          Map<String, dynamic> response = snapshot.data;
          List campaignLinks = response["campaign"];
          print(campaignLinks);
          List officeLinks = response["office"];

          return Column
          (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Campaign", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              getLinkWidgets(campaignLinks),
              SizedBox(height: 30),

              Text("Office", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              getLinkWidgets(officeLinks),
              SizedBox(height: 30)
            ]
          );

        }
        else if (snapshot.hasError) 
        {
          return Text("Error loading social media data", style: TextStyle(fontSize: 16));
        }

        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      }); 
  }
}

Future<Map<String, dynamic>> fetchSocialMediaLinks(String candidateId) async 
{
  //fetches candidate bio data from API
  var params = {
    "candidate_id" : candidateId
  };

  Uri uri = Uri.https("political-tap.herokuapp.com", "getSocialMediaLinks", params);
  final response = await http.get(uri);

  if (response.statusCode == 200) 
  {
    String body = response.body;
    final data = jsonDecode(body);

    return data;
  } 
  else 
  {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load candidate social media links');
  }
}

Widget getLinkWidgets(List links)
{
  if (links.length == 0)
  {
    return Text("Not available", style: TextStyle(fontSize: 16)); 
  }

  final socialMediaIcons = 
  {
    "twitter" : FontAwesomeIcons.twitterSquare,
    "facebook": FontAwesomeIcons.facebookSquare,
    "instagram" : FontAwesomeIcons.instagramSquare,
    "youtube" : FontAwesomeIcons.youtube,
    "linkedin" : FontAwesomeIcons.linkedin,
  };

  return new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: links.map((item) 
    {
      return new InkWell(
        child: Row(
          children: [
            FaIcon(socialMediaIcons[item["type"]], color: Color.fromARGB(255, 18, 0, 205)),
            SizedBox(width: 10),
            Text(
              item["address"], 
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 18, 0, 205), 
                decoration: TextDecoration.underline
              )
            )
          ],
        ),
        onTap: () {
          launch(item["address"]);
        },
      );
    }).toList()
  );
}