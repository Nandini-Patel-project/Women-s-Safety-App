import 'package:NPTY/widgets/liveSafe/BusStopCard.dart';
import 'package:NPTY/widgets/liveSafe/HospitalsCard.dart';
import 'package:NPTY/widgets/liveSafe/PharmacyCard.dart';
import 'package:NPTY/widgets/liveSafe/PoliceStationCard.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({Key? key}) : super(key: key);

  static Future<void> openMap(String location) async {
    String googleUrl = 'https://www.google.co.in/maps/search/$location';
    final Uri _url = Uri.parse(googleUrl);
    try {
      await launchUrl(_url);
    } catch (e) {
      // Fluttertoast.showToast(
      //     msg: 'Something went wrong !!! call emergency number.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceStationCard(onMapFunction: openMap),
          HospitalsCard(onMapFunction: openMap),
          PharmacyCard(onMapFunction: openMap),
          BusStopCard(onMapFunction: openMap),
        ],
      ),
    );
  }
}
