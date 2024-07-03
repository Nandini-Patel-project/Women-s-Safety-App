import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String locationMessage = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    // Fetch the location when the widget is initialized
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    // Check and request location permissions
    var status = await Permission.location.status;
    if (status == PermissionStatus.denied) {
      await Permission.location.request();
      status = await Permission.location.status;
    }

    if (status == PermissionStatus.granted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        setState(() {
          locationMessage =
              'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
        });

        // Open Google Maps with the current location
        openGoogleMaps(position.latitude, position.longitude);
      } catch (e) {
        print('Error fetching location: $e');
        setState(() {
          locationMessage = 'Failed to fetch location.';
        });
      }
    } else {
      print('Location permissions denied.');
      setState(() {
        locationMessage = 'Location permissions denied.';
      });
    }
  }

  Future<void> openGoogleMaps(double latitude, double longitude) async {
    // Construct the Google Maps URL with the current location
    String mapsUrl = 'https://maps.google.com/?daddr=$latitude,$longitude';

    // Check if the URL can be launched
    if (await canLaunch(mapsUrl)) {
      await launch(mapsUrl);
    } else {
      print('Could not launch Google Maps.');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Page'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Live Location:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                locationMessage,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
