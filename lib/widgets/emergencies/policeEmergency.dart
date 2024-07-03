import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PoliceEmergency extends StatelessWidget {
  final String phoneNumber =
      'tel:100'; // Replace '101' with the desired emergency number

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () {
            launch(phoneNumber);
          },
          child: SingleChildScrollView(
            child: Container(
              height: 167, // Adjusted height
              width: MediaQuery.of(context).size.width * 0.7, // Adjusted width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 248, 100, 100),
                    Color.fromARGB(255, 245, 173, 90),
                    Color.fromARGB(255, 245, 207, 132),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20, // Adjusted radius
                      child: ClipOval(
                        child: Image.asset("images/sos.jpg"),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Police",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width *
                                  0.05, // Adjusted font size
                            ),
                          ),
                          Text(
                            "Police 100 emergencies",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width *
                                  0.04, // Adjusted font size
                            ),
                          ),
                          Container(
                            height: 25, // Adjusted height
                            width: 70, // Adjusted width
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  15), // Adjusted border radius
                            ),
                            child: Center(
                              child: Text(
                                "1-0-0",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.04, // Adjusted font size
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
