import 'package:flutter/material.dart';

import 'AmbulanceEmergency_Screen.dart';
import 'FirebrigedeEmergency_Screen.dart';
import 'PoliceEmergency_Screen.dart';
import 'Renamed.dart';
class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:10,top:5),
      child: SizedBox(
        height:350,
        child: GridView.count(
            // childAspectRatio: 5 / 2,
            crossAxisCount: 2,
            crossAxisSpacing: 1.5,
            mainAxisSpacing: 1.5,
            children:[
              PoliceEmergency(),
              AmbulanceEmergency(),
              FirebrigedeEmergency(),
              newaddhare(),

            ]),
      ),
    );

  }
}
