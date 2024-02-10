import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DB/shere_Prefrences..dart';
import 'DB/shere_Prefrences..dart';
import 'Widget_Screen/ChildScreeen/Bottom_Page.dart';
import 'Widget_Screen/ChildScreeen/Child_Login_Screen.dart';
import 'Widget_Screen/ParentScreen/ParentHome_Screen.dart';
import 'Widget_Screen/SafeHome_Widget/GoogleMap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:450975758480:android:9b919a3fe65608ec488015',
      apiKey: 'AIzaSyCeTBozsvB3j23a1IEAeTjtFo1BwVGP-bA',
      messagingSenderId: '450975758480',
      projectId: 'vehicledispatchapp',
    ),
  );
  await MySharedPrefference.init();
  // await initializeService();
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
        primaryColor: Colors.blueAccent.shade700,useMaterial3: true,
      ),
      home: FutureBuilder(
        future: MySharedPrefference.getUserType(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final userType = snapshot.data;

          if (userType == null || userType.isEmpty) {
            return Login();
          }

          if (userType == "child") {
            return BottomPage();
          }

          if (userType == "parent") {
            return ParentHomeScreen();
          }

          return Login(); // Default to login if userType is not recognized
        },
      ),
    );
  }
}
// class CheckAuth extends StatelessWidget {
//   // const CheckAuth({Key? key}) : super(key: key);

//   checkData() {
//     if (MySharedPrefference.getUserType() == 'parent') {}
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
