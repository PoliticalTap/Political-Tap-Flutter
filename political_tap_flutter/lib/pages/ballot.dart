import 'package:flutter/material.dart';
import 'package:political_tap_flutter/main.dart';
import 'package:political_tap_flutter/models/candidate.dart';
import 'package:political_tap_flutter/widgets/ballot_widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Ballot extends StatefulWidget 
{
  @override
  _BallotState createState() => _BallotState();
}

class _BallotState extends State<Ballot> 
{
  Future<List<CandidateContainer>> candidateContainers;

  @override
  void initState()
  {
    super.initState();
    candidateContainers = fetchCandidates();
  }

  @override
  Widget build(BuildContext context) 
  {
    // TODO: Create custom Scaffold to use for all pages
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 0, 205),
        title: Text("Ballot"),
      ),
      drawer: NavDrawer(),
      body: FutureBuilder<List<CandidateContainer>>(
        future: candidateContainers,
        builder: (context, snapshot) 
        {
          if (snapshot.hasData) 
          {
            return ListView(children: snapshot.data);
          } 
          else if (snapshot.hasError) 
          {
            return Center(child: Text( "Candidate information failed to load. Please try again.", style: TextStyle(fontSize: 20) ));
          }

          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}

Future<List<CandidateContainer>> fetchCandidates() async 
{
  //fetches candidate data from API
  String url = "https://political-tap.herokuapp.com/testCandidate";
  final response = await http.get(url);

  if (response.statusCode == 200) 
  {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    String body = response.body;
    
    final data = jsonDecode(body);

    // Output List of Candidate Containers
    List<CandidateContainer> containers = new List();

    data.forEach((element) 
      {
        print(element["election"]);
        //list of candidates
        List<Candidate> candidateList = new List();

        element["candidates"].forEach((element) 
        {
          Candidate candidate = Candidate.fromJson(element);
          candidateList.add(candidate);
        });

        containers.add(CandidateContainer(title: element["election"], candidates: candidateList));
      }
    );
    return containers;
  } 
  else 
  {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load candidates');
  }
}
