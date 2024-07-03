import 'package:NPTY/widgets/emergencies/AmbulanceEmergency.dart';
import 'package:NPTY/widgets/emergencies/FirebrigadeEmergency.dart';
import 'package:NPTY/widgets/emergencies/policeEmergency.dart';
import 'package:flutter/material.dart';

class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceEmergency(),
          AmbulanceEmergency(),
          FirebrigadeEmergency(),
        ],
      ),
    );
  }
}
