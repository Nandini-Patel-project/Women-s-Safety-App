import 'dart:math';

import 'package:NPTY/Contact.dart';
import 'package:NPTY/loginpage.dart';
import 'package:NPTY/securityFeatures.dart';
import 'package:NPTY/widgets/customAppBar.dart';
import 'package:NPTY/widgets/customCarouel.dart';
import 'package:NPTY/widgets/emergencies/sos.dart';
import 'package:NPTY/widgets/emergency.dart';
import 'package:NPTY/widgets/livesafe.dart';
import 'package:flutter/material.dart';

import 'MotivationalVideoPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController usernameController = TextEditingController();
  bool isEditing = false;

  int qIndex = 0;

  getRandomQuote() {
    setState(() {
      qIndex = Random().nextInt(6);
    });
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _performLogout();
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _performLogout() {
    // Clear user authentication or any other necessary cleanup
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );

    // Show success message using SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Logged out successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleAlertButtonPress() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SOS()),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> videoIds = [
      'KVpxP3ZZtAc',
      'k9Jn0eP-ZVg',
      'UUFjEHazDjU',
      // Add more video IDs as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wesafe',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 220, 238, 248),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 139, 102, 243),
        ),
        child: Center(
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                color: Color.fromARGB(0, 0, 0, 0),
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SecurityFeaturesPage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.security,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            label: Text('Security Features'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              textStyle: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ContactEntryApp(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.contacts,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            label: Text('Manage Contacts'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              onPrimary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              textStyle: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MotivationalVideoPage(
                                    videoIds: videoIds,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.play_arrow,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            label: Text('Defence Videos'),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 36, 90, 238),
                              onPrimary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              textStyle: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          ElevatedButton.icon(
                            onPressed: () {
                              _handleAlertButtonPress(); // Call the function to handle Alert button press
                            },
                            icon: Icon(
                              Icons.play_arrow,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            label: Text('Alert button'),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 192, 17, 4),
                              onPrimary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12.0),
                              textStyle: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  CustomAppBar(
                    quoteIndex: qIndex,
                    onTap: () {
                      getRandomQuote();
                    },
                  ),
                  CustomCarouel(),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Emergency",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Emergency(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Explore LiveSafe",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        LiveSafe(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          width: 200,
          height: 300,
          color: Color.fromARGB(255, 201, 185, 238).withOpacity(0.5),
          child: Card(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                        ),
                        Icon(
                          Icons.person,
                          color: const Color.fromARGB(255, 246, 245,
                              247), // Change the icon color to purple
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: isEditing
                        ? TextField(
                            controller: usernameController,
                            decoration: InputDecoration(labelText: 'Username'),
                          )
                        : Text(
                            usernameController.text,
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      iconColor: Color.fromARGB(255, 23, 26, 226),
                      title: Text('Settings'),
                      onTap: () {
                        // Handle settings tap
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ListTile(
                      leading: Icon(Icons.exit_to_app),
                      iconColor: Color.fromARGB(255, 235, 28, 56),
                      title: Text('Log Out'),
                      onTap: () {
                        _showLogoutDialog(); // Call the logout confirmation dialog
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      iconColor: Color.fromARGB(255, 23, 128, 2),
                      title: Text(isEditing ? 'Save' : 'Edit Profile'),
                      onTap: () {
                        setState(() {
                          if (isEditing) {
                            // Save the edited username
                            // You can add code to save the username to your backend
                          }
                          isEditing = !isEditing; // Toggle edit mode
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
