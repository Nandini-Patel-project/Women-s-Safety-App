import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class SOS extends StatefulWidget {
  @override
  _SOSPageState createState() => _SOSPageState();
}

class _SOSPageState extends State<SOS> {
  List<String> emergencyContacts = [];
  LocationData? currentLocation;

  @override
  void initState() {
    super.initState();
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
    String message = 'Please help me, I am in danger!';

    Location location = Location();
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      print('Failed to get location: $e');
      return;
    }

    String googleMapsLink =
        'https://maps.google.com/?daddr=${currentLocation!.latitude},${currentLocation!.longitude}';

    message += '\nMy current location: $googleMapsLink';

    String contactsString = emergencyContacts.join(',');

    String smsUrl = 'sms:$contactsString?body=${Uri.encodeComponent(message)}';

    if (await canLaunch(smsUrl)) {
      await launch(smsUrl);
      print('SMS sent to: $contactsString');
    } else {
      print('Could not launch SMS to: $contactsString');
    }

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
