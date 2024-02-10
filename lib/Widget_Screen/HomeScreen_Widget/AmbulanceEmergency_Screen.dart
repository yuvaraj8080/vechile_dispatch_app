

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';


class AmbulanceEmergency extends StatelessWidget {

  _callNumber(String number) async{
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,top:2),
      child: GestureDetector(
        onTap: (){
          _callNumber("102");
        },
        child: Card(
          elevation: 3,shadowColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xffe6e9f0),
                    Color(0xffeef1f5),
                  ],
                )),
            child: Padding(
              padding: const EdgeInsets.only(top:20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: Image.asset('assets/images/ambulance.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:15,),
                    child: Center(
                      child: Text("Ambulance",style:GoogleFonts.roboto(fontSize:20,
                          fontWeight:FontWeight.bold,color:Colors.black)),
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