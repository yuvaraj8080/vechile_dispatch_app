import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';

class newaddhare extends StatelessWidget {
  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Column(
        children: [
          SizedBox(
            height: 130, // Adjust the height here
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 2),
              child: GestureDetector(
                onTap: () {
                  _callNumber("1091");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffe6e9f0),
                        Color(0xffeef1f5),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white.withOpacity(0.8),
                            child: Image.asset('assets/images/alert.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Center(
                            child: Text(
                              "Women Help",
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Repeat the above widget for other children
        ],
      ),
    );

  }
}
