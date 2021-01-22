import 'package:flutter/material.dart';
import 'package:political_tap_flutter/main.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget 
{
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  String locationString = "Press to get location.";

  Future<bool> _checkLocationServices() async
    {
      setState(() {
        locationString = "Checking Location Services Permissions...";
      });

      // Check if Location Services is enabled on the device; Request to enable if it is not
      _serviceEnabled = await location.serviceEnabled();

      if (_serviceEnabled == null || !_serviceEnabled) 
      {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) { return false; }
      }

      // Check for Location Permissions; Request permission if it isn't given
      _permissionGranted = await location.hasPermission();

      if (_permissionGranted != PermissionStatus.granted) 
      {
        _permissionGranted = await location.requestPermission();
      }

      return _serviceEnabled && (_permissionGranted == PermissionStatus.granted);
    }

  Future<void> _getLocation() async 
  {
    bool hasLocationAccess = await _checkLocationServices();

    if (!hasLocationAccess)
    {
      setState(() {
        // TODO: Work on message wording
        locationString = "Location services not enabled or location permission not granted. Please check your settings to use this feature.";
      });

      return;
    }
    else
    {
      setState(() {
        locationString = "Loading...";
      });

      _locationData = await location.getLocation();

      var latitude = _locationData.latitude.toString();
      var longitude = _locationData.longitude.toString();

      var params = {
        "latitude" : latitude,
        "longitude" : longitude
      };

      Uri uri = Uri.https("political-tap.herokuapp.com", "getZipFromLocation", params);
      final response = await http.get(uri);

      if (response.statusCode == 200) 
      {
        String body = response.body;
        setState(() {
          locationString = body;
        });
        
        final prefs = await SharedPreferences.getInstance();

        // Saves the zip code
        prefs.setString('userZip', body);
        
      } 
      else 
      {
        setState(() {
          locationString = "Could not determine zipcode";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 0, 205),
        title: Text("Settings"),
      ),
      drawer: NavDrawer(),
      body: ListView(
        children: 
        [
          Container(
            child: Text("$locationString"),
          ),
          Container
          (  
            margin: EdgeInsets.all(25),  
            child: FlatButton(  
              child: Text('Get GPS coordinates', style: TextStyle(fontSize: 20.0),),  
              color: Colors.blueAccent,  
              textColor: Colors.black,  
              onPressed: () async
              {
                await _getLocation();
              },  
            ), 
          ),

        ],
      )
    );
    
  }
}