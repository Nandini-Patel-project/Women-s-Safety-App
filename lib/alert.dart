import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSPage extends StatefulWidget {
  @override
  _SOSPageState createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  List<String> emergencyContacts = [];
  LocationData? currentLocation; // Add "?" for nullable type

  @override
  void initState() {
    super.initState();
    // Call the backend API to get emergency contacts
    fetchEmergencyContacts();
  }

  Future<void> fetchEmergencyContacts() async {
    final response =
        await http.get(Uri.parse('http://192.168.0.102/registerAPI/sos.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('error')) {
        print('Error: ${data['error']}');
      } else {
        setState(() {
          emergencyContacts = [
            data['contact1'],
            data['contact2'],
            data['contact3'],
          ];
        });
      }
    } else {
      print(
          'Failed to fetch emergency contacts. Status code: ${response.statusCode}');
    }
  }

  Future<void> _sendAlertMessage(BuildContext context) async {
    // Implement the logic to send alert messages
    // For simplicity, let's create a Google Maps link with the live location
    String message = 'Please help me, I am in danger!';

    // Get the device's location
    Location location = Location();
    try {
      currentLocation = await location.getLocation();
      _getAddressFromLatLon(); // Call the function to get the address
    } catch (e) {
      print('Failed to get location: $e');
      // Handle the error as needed
      return;
    }

    // Create a Google Maps link with latitude and longitude
    String googleMapsLink =
        'https://maps.google.com/?daddr=${currentLocation!.latitude},${currentLocation!.longitude}';

    message += '\nMy current location: $googleMapsLink';

    for (String contact in emergencyContacts) {
      String smsUrl = 'sms:$contact?body=${Uri.encodeComponent(message)}';

      if (await canLaunch(smsUrl)) {
        await launch(smsUrl);
        print('SMS sent to: $contact');
      } else {
        print('Could not launch SMS to: $contact');
        // Handle the error as needed
      }
    }

    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('SOS Alert Sent'),
          content: Text('Emergency contacts have been notified.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Add the missing function to get the address
  Future<void> _getAddressFromLatLon() async {
    // Implement this function to get the address from latitude and longitude
    // You may use a geocoding service or any suitable method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Press the SOS button to send alerts with your live location!',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _sendAlertMessage(context);
              },
              child: Text('Send SOS Alert'),
            ),
          ],
        ),
      ),
    );
  }
}
