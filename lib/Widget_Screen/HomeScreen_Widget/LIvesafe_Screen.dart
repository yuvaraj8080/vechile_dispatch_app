import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/Utils.dart';
import '../LiveSafe_Widget/FireBrigade_card.dart';
import '../LiveSafe_Widget/HospitalCard.dart';
import '../LiveSafe_Widget/PoliceStationCard.dart';
class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});

  static  Future<void> openMap(String location)async{
    String googleUrl = "https://www.google.com/maps/search/$location";
    final Uri _url = Uri.parse(googleUrl);

    try{
      await launchUrl(_url);
    }
    catch(e){
      Utils().showError("something went wrong! call emergency number");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color:Colors.grey.shade900,
      elevation:2,shadowColor: Colors.white,
      child: Container(
        height:80,decoration:BoxDecoration(
        borderRadius:BorderRadius.circular(10),
          gradient:LinearGradient(
        colors: [
          Color(0xffe6e9f0),
          Color(0xffeef1f5),
        ]
      )),
          width:MediaQuery.of(context).size.width,
        child:Padding(
          padding: const EdgeInsets.only(left:5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                  PoliceStation(onMapFunction:openMap),
                  Hospital(onMapFunction:openMap),
                  Firebrigade(onMapFunction:openMap),
            ],
          ),
        )
      ),
    );
  }
}
