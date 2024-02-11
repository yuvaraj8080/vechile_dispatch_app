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
        height:300,
        child: GridView.count(

            // childAspectRatio: 5 / 2,
            crossAxisCount: 2,
            crossAxisSpacing:0.1,
            mainAxisSpacing:0.1,
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
