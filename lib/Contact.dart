import 'dart:convert';

import 'package:NPTY/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradiantbutton/gradiantbutton.dart'; // Import for FilteringTextInputFormatter
import 'package:http/http.dart' as http;

class ContactEntryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Entry App',
      home: ContactEntryScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ContactEntryScreen extends StatefulWidget {
  @override
  _ContactEntryScreenState createState() => _ContactEntryScreenState();
}

class _ContactEntryScreenState extends State<ContactEntryScreen> {
  TextEditingController contact1 = TextEditingController();
  TextEditingController contact2 = TextEditingController();
  TextEditingController contact3 = TextEditingController();

  List<String> savedContacts = [];

  bool _validatePhoneNumber(String value) {
    // Validate phone number length
    if (value.length != 10) {
      return false;
    }
    return true;
  }

  Future<void> insertcontact() async {
    if (_validatePhoneNumber(contact1.text) &&
        _validatePhoneNumber(contact2.text) &&
        _validatePhoneNumber(contact3.text)) {
      try {
        String uri = "http://192.168.0.110/registerAPI/insertcont.php";
        var res = await http.post(
          Uri.parse(uri),
          body: {
            'contact1': contact1.text,
            'contact2': contact2.text,
            'contact3': contact3.text,
          },
        );

        if (res.statusCode == 200) {
          try {
            var response = jsonDecode(res.body);
            if (response["success"] == "true") {
              print("Successfully contact saved");
              setState(() {
                savedContacts.add(contact1.text);
                savedContacts.add(contact2.text);
                savedContacts.add(contact3.text);
              });
              showSuccessDialog(context);
              navigateToHomeScreen();
            } else {
              print("Server returned an error: ${response["message"]}");
              showErrorDialog(context, 'Error: ${response["message"]}');
            }
          } catch (e) {
            print("Failed to decode JSON response");
            print("Server response: ${res.body}");
            showErrorDialog(context, 'Error: Failed to decode JSON response');
          }
        } else {
          print("Server responded with status code ${res.statusCode}");
          print("Server response: ${res.body}");
          showErrorDialog(context,
              'Error: Server responded with status code ${res.statusCode}');
        }
      } catch (e) {
        print(e);
        showErrorDialog(context, 'Error: $e');
      }
    } else {
      print("Please fill all fields or enter valid phone numbers");
      showErrorDialog(context, 'Error: Please fill all fields or enter valid phone numbers');
    }
  }

  Future<void> deleteContact(String number) async {
    try {
      String uri = "http://192.168.0.102/registerAPI/deletecont.php";
      var res = await http.post(
        Uri.parse(uri),
        body: {
          'number': number,
        },
      );

      if (res.statusCode == 200) {
        setState(() {
          savedContacts.remove(number);
        });
        print("Contact deleted successfully");
      } else {
        print("Failed to delete contact");
        print("Server responded with status code ${res.statusCode}");
        print("Server response: ${res.body}");
        showErrorDialog(context, 'Error: Failed to delete contact');
      }
    } catch (e) {
      print(e);
      showErrorDialog(context, 'Error: $e');
    }
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Contacts saved successfully!'),
          actions: <Widget>[
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

  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
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

  void navigateToHomeScreen() {
    // Navigate to the home screen
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(232, 240, 235, 235),
      appBar: AppBar(
        title: Text(
          'Enter Contacts',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            height: 550,
            decoration: BoxDecoration(
              color: Color.fromARGB(1, 5, 5, 5),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(108, 5, 5, 5),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: savedContacts.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(savedContacts[index]),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteContact(savedContacts[index]);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 30),
                 TextField(
  controller: contact1,
  decoration: InputDecoration(
    labelText: 'Contact 1',
    labelStyle: TextStyle(color: Colors.white),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    prefixIcon: Icon(
      Icons.phone,
      color: Colors.white,
    ),
//     suffixIcon: IconButton(
//   icon: Icon(
//     Icons.delete,
//     color: const Color.fromARGB(255, 241, 236, 236),
//   ),
//   onPressed: () {
//      setState(() {
//       savedContacts.remove(contact1.text);
//       contact1.clear();
//     });
//     // contact1.clear();
//   },
// ),

  ),
  style: TextStyle(color: Colors.white),
  keyboardType: TextInputType.number,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10), // Limit to 10 characters
  ],
),

                  SizedBox(height: 30),
                  TextField(
                    controller: contact2,
                    decoration: InputDecoration(
                      labelText: 'Contact 2',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10), // Limit to 10 characters
                    ],
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: contact3,
                    decoration: InputDecoration(
                      labelText: 'Contact 3',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10), // Limit to 10 characters
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: GradiantButton(
                      child: Text(
                        'Save Contact',
                        style: TextStyle(
                          color: Color.fromARGB(255, 252, 250, 250),
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(255, 238, 40, 5),
                          Color.fromARGB(255, 15, 170, 231),
                        ],
                      ),
                      onPressed: () {
                        insertcontact();
                      },
                      width: 200,
                      radius: 300,
                      height: 200,
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
