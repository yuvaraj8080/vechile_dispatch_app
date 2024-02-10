import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DB/shere_Prefrences..dart';
import 'Widget_Screen/AdminScreen/Admin_Profile/Admin_bottom_Screen.dart';
import 'Widget_Screen/UserScreen/Bottom_Page.dart';
import 'Widget_Screen/UserScreen/Main_Login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:450975758480:android:9b919a3fe65608ec488015',
      apiKey: 'AIzaSyCeTBozsvB3j23a1IEAeTjtFo1BwVGP-bA',
      messagingSenderId: '450975758480',
      projectId: 'vehicledispatchapp',
      storageBucket: "vehicledispatchapp.appspot.com"
    ),
  );
  await MySharedPrefference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent.shade700,
        // useMaterial3: true, // Removed this line
      ),
      home: FutureBuilder(
        future: MySharedPrefference.getUserType(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Wrapped with const
          }

          final userType = snapshot.data;

          if (userType == null || userType.isEmpty) {
            return  Login(); // Wrapped with const
          }

          if (userType == "child") {
            return const BottomPage(); // Wrapped with const
          }

          if (userType == "parent") {
            return const Admin_Bottom_page(); // Wrapped with const
          }

          return  Login(); // Default to login if userType is not recognized
        },
      ),
    );
  }
}
