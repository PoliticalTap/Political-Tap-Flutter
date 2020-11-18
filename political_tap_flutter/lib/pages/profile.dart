import 'package:flutter/material.dart';
import 'package:political_tap_flutter/widgets/profile_widgets.dart';
import 'package:political_tap_flutter/models/candidate_bio.dart';
import 'package:political_tap_flutter/models/profile_arguments.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Profile extends StatefulWidget 
{

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> 
{
  Future<CandidateBio> candidateBio;

  @override
  void initState()
  {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) 
  {
    final ProfileArguments args = ModalRoute.of(context).settings.arguments;
    final String candidateId = args.candidateId;

    // Retrieve profile data for candidate 
    candidateBio = fetchCandidateBio(candidateId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Color.fromARGB(255, 18, 0, 205),
        elevation: 0
      ),
      body: FutureBuilder<CandidateBio>(
        future: candidateBio,
        builder: (context, snapshot) 
        {
          if (snapshot.hasData) 
          {
            return ProfileTabController(candidateBio: snapshot.data);
          } 
          else if (snapshot.hasError) 
          {
            return Center(child: Text("Candidate information failed to load or may no longer exist.", style: TextStyle(fontSize: 20) ));
          }

          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}

Future<CandidateBio> fetchCandidateBio(String candidateId) async 
{
  //fetches candidate bio data from API
  var params = {
    "candidate_id" : candidateId
  };

  Uri uri = Uri.https("political-tap.herokuapp.com", "getCandidate", params);
  final response = await http.get(uri);

  if (response.statusCode == 200) 
  {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    String body = response.body;

    CandidateBio candidateBio = CandidateBio.fromJson(json.decode(body));

    return candidateBio;
  } 
  else 
  {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load candidate information');
  }
}