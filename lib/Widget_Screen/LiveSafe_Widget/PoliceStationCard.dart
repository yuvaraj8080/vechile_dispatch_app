import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoliceStation extends StatelessWidget {
  final Function(String) onMapFunction;

  const PoliceStation({Key? key, required this.onMapFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, top: 5),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              // Send help message with current location
              onMapFunction("Police Station's near me");
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 40,
                width: 40,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueAccent.withOpacity(0.8),
                  child: Image.asset('assets/images/police6.png', height: 35),
                ),
              ),
            ),
          ),
          Text(
            "Police",
            style: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
