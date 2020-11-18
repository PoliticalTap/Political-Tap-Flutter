import 'package:flutter/material.dart';

class CandidateBio
{
  // Attributes
  String candidateId;
  String name;
  String position;
  String politicalParty;
  String imageUrl;
  ImageProvider profileImage;
  String birthDate;
  String family;
  String gender;
  String homeCity;
  String homeState;
  String religion;

  // TODO: Include other fields - office, org membership, education, office, political, profession, etc.
  
  // Constructor
  CandidateBio({this.candidateId, this.name, this.position, this.politicalParty, this.imageUrl, this.profileImage, this.birthDate, this.family, this.gender, this.homeCity, this.homeState, this.religion})
  {
    if (this.imageUrl != null && this.imageUrl != "")
    {
      profileImage = NetworkImage(this.imageUrl);
    }
    else
    {
      profileImage = AssetImage("assets/profile_default_img.png");
    }
  }

  // Populate candidate from JSON
  factory CandidateBio.fromJson(Map<String, dynamic> json) 
  {
    return CandidateBio
    (
      candidateId: json['candidate_id'],
      name: json['name'], 
      politicalParty: json['party'],
      imageUrl: json['photo'],
      birthDate: json['birthDate'],
      family: json['family'],
      gender: json['gender'],
      homeCity: json['homeCity'],
      homeState: json['homeState'],
      religion: json['religion']
    );
  }
}