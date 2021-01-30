import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:political_tap_flutter/palette.dart';

class LocationForm extends StatefulWidget {
  @override
  _LocationFormState createState() => _LocationFormState();
  final VoidCallback redirectFunction;

  LocationForm({this.redirectFunction});
}

class _LocationFormState extends State<LocationForm> {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  String locationString = "Press to get location.";
  
  final _zipKey= GlobalKey<FormState>();
  final zipTextController = TextEditingController();

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
        locationString = "Location services not enabled or location permission not granted. Please check your settings to use this feature.";
      });

      return;
    }
    else
    {
      setState(() {
        locationString = "Getting zip code from location...";
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
        
        saveZip(body);
      } 
      else 
      {
        setState(() {
          locationString = "Could not determine zipcode";
        });
      }
    }
  }

  void saveZip(zipCode) async
  {
    final prefs = await SharedPreferences.getInstance();

    // Saves the zip code
    prefs.setString('userZip', zipCode);
    
    setState(() {
      setState(() { locationString = "Displaying candidate information for zip code: " + zipCode; });
    });

    widget.redirectFunction();
  }

  void setZipState() async
  {
    final prefs = await SharedPreferences.getInstance();
    final zipcode = prefs.getString("userZip");

    if (zipcode == null)
    {
      setState(() { 
        locationString = "Political Tap needs your zip code to display candidates for your district. Please use one of the following options below to provide your zip code."; 
      });
    }
    else
    {
      setState(() { locationString = "Displaying candidate information for zip code: " + zipcode; });
    }
  }

  @override
  void initState()
  {
    super.initState();
    setZipState();
  }

  @override
  void dispose()
  {
    zipTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _zipKey,
      child: Container
      (
        child: ListView
        (
          children: [
            Text("$locationString", style: TextStyle(fontSize: 16)),

            TextFormField
            (
              controller: zipTextController,
              decoration: InputDecoration
              (
                hintText: "Enter your zip code."
              ),
              validator: (value) 
              {
                return ! (double.tryParse(value) != null && value.length == 5) ? "Please enter a valid zip code." : null;
              }
            ),

            FlatButton
            (  
              child: Text('Submit Zip Code'),  
              color: primaryRed,
              textColor: Colors.white,
              onPressed: () async
              {
                if (_zipKey.currentState.validate())
                {
                  saveZip(zipTextController.text);
                }
              },  
            ),

            FlatButton
            (  
              child: Text('Use My Device Location'),  
              color: primaryRed,
              textColor: Colors.white,
              onPressed: () async
              {
                await _getLocation();
              },  
            ),
          ]
        ),
      )
    );
  }
}

