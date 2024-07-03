import 'package:flutter/material.dart';

class BusStopCard extends StatelessWidget {
  final Function? onMapFunction;
  const BusStopCard({Key? key, this.onMapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction!('Bus stops near me');
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
                    "images/bus_stop.jpg",
                    height: 50,
                  ),
                ),
              ),
            ),
          ),
          Text(
            "Bus Stops",
          )
        ],
      ),
    );
  }
}
