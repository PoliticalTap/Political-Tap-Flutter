import 'package:flutter/material.dart';
import 'package:political_tap_flutter/models/candidate.dart';
import 'package:political_tap_flutter/models/profile_arguments.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dynamic_expansion_tile.dart';

class CandidateCard extends StatefulWidget 
{
  final Candidate candidate;

  // Set Candidate as input param for constructor
  CandidateCard({@required this.candidate});

  @override
  _CandidateCardState createState() => _CandidateCardState();
}

class _CandidateCardState extends State<CandidateCard> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Card(
      child: new InkWell(
        onTap: () => Navigator.pushNamed(context, "/profile", arguments: ProfileArguments(candidateId: widget.candidate.candidateId)),
        child:Column(
          children: 
          [
            Expanded(child: widget.candidate.profileImage),
            Divider(thickness: 2),
            Text(widget.candidate.name, style: TextStyle(fontSize: 20)),
            Text(widget.candidate.politicalParty)
          ]
        )
      )
    );
  }
}

class CandidateContainer extends StatefulWidget 
{
  final String title;
  final List<Candidate> candidates;

  CandidateContainer({@required this.title, @required this.candidates});

  @override
  _CandidateContainerState createState() => _CandidateContainerState();
}

class _CandidateContainerState extends State<CandidateContainer> 
{
  @override
  Widget build(BuildContext context) 
  {
    return DynamicExpansionTile(
      title: 
        Text(
          widget.title,
          style: GoogleFonts.merriweather(
            color: Colors.white
          )
        ),
      titleColor: Color.fromARGB(255, 221, 17, 17),
      trailingColor: Colors.white,
      initiallyExpanded: true,
      children: 
      [
        OrientationBuilder(builder: (context, orientation)
          {
            // Use orientation builder to set the number of cards per row based on orientation
            return GridView.count(
              crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
              children: widget.candidates.map((candidate) => CandidateCard(candidate: candidate)).toList(),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            );
          }
        ),
        SizedBox(height: 25)
      ]
    );
  }
}