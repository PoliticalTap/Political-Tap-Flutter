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
  List<String> education;
  List<String> office;
  List<String> orgMembership;
  List<String> political;
  List<String> profession;
  
  // Constructor
  CandidateBio(
    { this.candidateId, this.name, this.position, this.politicalParty, this.imageUrl, this.profileImage, this.birthDate, this.family, 
      this.gender, this.homeCity, this.homeState, this.religion, this.education, this.office, this.orgMembership, this.political, this.profession})
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
    // check for multiple educations
    List<String> educationList = new List();
    if (json["education"] is String)
    {
      educationList.add(json["education"]);
    }
    else if (json['education'].containsKey("institution") && json['education']['institution'] is List)
    {
      for (var institution in json['education']['institution']) 
      {
        educationList.add(institution["fullText"]);
      }
    }
    else
    {
      educationList.add(json["education"]["institution"]["fullText"]);
    }

    // check for multiple offices
    List<String> officeList = new List();
    if (json["office"] is String)
    {
      officeList.add(json["office"]);
    }
    else if (json['office'] is List)
    {
      for (var office in json['office']) 
      {
        officeList.add("Type: " + office["type"] + "\nTitle: " +  office["title"] + "\nStatus: " + office["status"]);
      }
    }
    else
    {
      officeList.add("Type: " + json["office"]["type"] + "\nTitle: " +  json["office"]["title"] + "\nStatus: " + json["office"]["status"]);
    }

    // check for multiple org memberships
    List<String> orgMembershipList = new List();
    if (json["orgMembership"] is String)
    {
      orgMembershipList.add(json["orgMembership"]);
    }
    else if (json['orgMembership'].containsKey("experience") && json['orgMembership']['experience'] is List)
    {
      for (var experience in json['orgMembership']['experience']) 
      {
        orgMembershipList.add(experience["fullText"]);
      }
    }
    else
    {
      orgMembershipList.add(json["orgMembership"]["experience"]["fullText"]);
    }

    print("no issues here");

    // check for multiple political experiences
    List<String> politicalList = new List();
    if (json["political"] is String)
    {
      politicalList.add(json["political"]);
    }
    else if (json['political'].containsKey("experience") && json['political']['experience'] is List)
    {
      for (var experience in json['political']['experience']) 
      {
        politicalList.add(experience["fullText"]);
      }
    }
    else
    {
      politicalList.add(json["political"]["experience"]["fullText"]);
    }

    // check for multiple professions
    List<String> professionList = new List();
    if (json["profession"] is String)
    {
      professionList.add(json["profession"]);
    }
    else if (json['profession'].containsKey("experience") && json['profession']['experience'] is List)
    {
      for (var experience in json['profession']['experience']) 
      {
        professionList.add(experience["fullText"]);
      }
    }
    else
    {
      professionList.add(json["profession"]["experience"]["fullText"]);
    }

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
      religion: json['religion'],
      education: educationList,
      office: officeList,
      orgMembership: orgMembershipList,
      political: politicalList,
      profession: professionList
    );
  }
}