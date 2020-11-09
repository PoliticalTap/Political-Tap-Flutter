import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:political_tap_flutter/models/candidate.dart';
import 'package:political_tap_flutter/models/profile_arguments.dart';

class Profile extends StatelessWidget 
{

  @override
  Widget build(BuildContext context) 
  {
    final ProfileArguments args = ModalRoute.of(context).settings.arguments;
    final Candidate candidate = args.candidate;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color.fromARGB(255, 18, 0, 205),
        elevation: 0
      ),
      body: DefaultTabController(
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
                flexibleSpace: FlexibleSpaceBar(background: ProfileTitle(candidate: candidate))
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    tabs: 
                    [
                      Tab(text: "About"),
                      Tab(text: "Posts"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: new TabBarView(
              children: 
              [
                Container(child: Center(child: Text("[Insert Bio]"))),
                ListView(scrollDirection: Axis.vertical, shrinkWrap: true, children: stuff),
              ]
          ),
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
      child: _tabBar,
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
  final Candidate candidate;

  ProfileTitle({@required this.candidate});

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
              backgroundImage: widget.candidate.imageUrl == null ? AssetImage("assets/profile_default_img.png") : NetworkImage(widget.candidate.imageUrl),
              radius: 40.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              [
                Text(
                  widget.candidate.name,
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
                // Text("Candidate for ${widget.candidate}",style: TextStyle(color: Colors.white),),
                Text(widget.candidate.politicalParty,style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> stuff = 
[
  Container(child: Text("Tweet #1", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #2", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #3", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #4", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #5", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #6", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #7", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #8", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #9", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #10", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #11", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #12", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #13", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #14", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #15", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #16", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #17", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #18", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #19", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #20", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #21", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #22", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #23", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #24", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #25", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #26", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #27", style: TextStyle(fontSize: 30),)),
  Container(child: Text("Tweet #28", style: TextStyle(fontSize: 30),)),
];