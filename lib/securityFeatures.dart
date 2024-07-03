import 'package:NPTY/LocationPage.dart';
import 'package:NPTY/alert.dart';
import 'package:flutter/material.dart';

class SecurityFeaturesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security Features'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Color.fromARGB(255, 219, 211, 219), // Set pink background color
        child: Center(
          child: Container(
            width: 350,
            height: 500,
            color: Colors.black.withOpacity(0.5),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Safety Features',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 145, 225, 228),
                      ),
                    ),
                    SizedBox(height: 20),
                    SafetyFeatureCard(
                      title: 'Location',
                      description: 'See your location where you are in present',
                      icon: Icons.location_on,
                      onTap: () {
                        // Navigate to LocationPage when the Location feature is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationPage(),
                          ),
                        );
                      },
                    ),
                    SafetyFeatureCard(
                      title: 'SOS Alert',
                      description:
                          'Trigger an SOS alert to alert your contacts.',
                      icon: Icons.warning,
                      onTap: () {
                        // Navigate to SOSAlertPage when SOS alert is triggered
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SOSPage(
                                // emergencyContacts: [
                                //   "contact1",
                                //   "contact2",
                                //   "contact3"
                                // ], // Pass your emergency contacts here
                                ),
                          ),
                        );
                      },
                    ),
                    SafetyFeatureCard(
                      title: 'Message',
                      description:
                          'Write a message that you want to send when you are in an emergency.',
                      onTap: () {
                        // Add functionality to access safe route planning.
                      },
                      icon: Icons.message,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SafetyFeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  SafetyFeatureCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40,
                color: Color.fromARGB(255, 105, 146, 8),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 74, 33, 223),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Color.fromARGB(255, 79, 28, 219),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
