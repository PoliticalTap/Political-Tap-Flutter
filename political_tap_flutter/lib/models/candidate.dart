import 'package:flutter/material.dart';

class Candidate
{
  // Attributes
  String candidateId;
  String name;
  String politicalParty;
  String imageUrl;
  Image profileImage;
  
  // Constructor
  Candidate({this.candidateId, this.name, this.politicalParty, this.imageUrl})
  {
    if (this.imageUrl != null && this.imageUrl != "")
    {
      profileImage = Image.network(this.imageUrl);
    }
    else
    {
      profileImage = Image.asset("assets/profile_default_img.png");
    }
  }

  // Populate candidate from JSON
  factory Candidate.fromJson(Map<String, dynamic> json) 
  {
    return Candidate
    (
      candidateId: json['candidate_id'],
      name: json['name'], 
      politicalParty: json['party'],
      imageUrl: json['photo']
    );
  }
}