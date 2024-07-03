import 'package:flutter/material.dart';

class PoliceStationCard extends StatelessWidget {
  final Function? onMapFunction;
  const PoliceStationCard({Key? key, this.onMapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction!('Police stations near me');
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                color: Colors.white,
                height: 62,
                width: 70,
                child: Center(
                  child: Image.asset(
                    "images/policeBadge.png",
                    height: 50,
                  ),
                ),
              ),
            ),
          ),
          Text("Police Stations")
        ],
      ),
    );
  }
}
