import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import '../../../Chat_Module/ChatBot.dart';
import '../../../Constants/Constants.dart';
import '../../../Constants/Utils.dart';
import '../../../Constants/contactsm.dart';
import '../../../DB/db_services.dart';
import '../../HomeScreen_Widget/LIvesafe_Screen.dart';
import '../../HomeScreen_Widget/emergency_Screen.dart';
import '../../SafeHome_Widget/SafeHome_Screen.dart';
import '../Main_Login_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({super.key});
  int qIndex = 0;
  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;
  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    final Telephony telephony = Telephony.instance;
    await telephony.requestPhoneAndSmsPermissions;
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _curentPosition = position;
        print(_curentPosition!.latitude);
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Utils().showError( e.toString());
    });
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _curentPosition!.latitude, _curentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
        "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      Utils().showError( e.toString());
    }
  }

  getRandomSafeText() {
    Random random = Random();
    setState(() {
      qIndex = random.nextInt(6);
    });
  }

  getAndSendSms() async {
    List<TContact> contactList = await DatabaseHelper().getContactList();

    String messageBody =
        "https://maps.google.com/?daddr=${_curentPosition!.latitude},${_curentPosition!.longitude}";
    if (await _isPermissionGranted()) {
      contactList.forEach((element) {
        // _sendSms("${element.number}", "i am in trouble $messageBody");
      });
    } else {
      Utils().showError("something wrong");
    }
  }

  @override
  void initState() {
    getRandomSafeText();
    super.initState();
    _getPermission();
    _getCurrentLocation();

  }
  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom:  PreferredSize(
            preferredSize:Size.fromHeight(10), // Adjust height as needed
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(backgroundImage:AssetImage("assets/images/res.png",),radius: 25,),
                      SizedBox(width:25,),
                      Text('ResQ Dispatch',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width:30,),
                   IconButton(icon: Icon(Icons.logout,color:Colors.grey,),onPressed: () async {
                     try {
                       await FirebaseAuth.instance.signOut();
                       goTo(context, Login());
                     } on FirebaseAuthException catch (e) {
                       Utils().showError(e.toString());
                     }
                   },)
      
                ],
              ),
            ),
      
          ),
      
        ),
        body:SingleChildScrollView(
          child: Column(
              children:[
                const SizedBox(height:3),
                Row(children: [
                    Text("   Emergency helpline",style:GoogleFonts.lato(fontSize:18,
                        fontWeight:FontWeight.bold,color:Colors.white)),
                  ],
                ),
                 Emergency(),
                Row(children: [
                    Text("   Explore LiveSafe",style:GoogleFonts.lato(fontSize:18,
                        fontWeight:FontWeight.bold,color:Colors.white)),
                  ],
                ),
                const LiveSafe(),
                SizedBox(height:5,),
                SafeHome(),
      
                ]),
        ),
      ),
    );
  }
}
