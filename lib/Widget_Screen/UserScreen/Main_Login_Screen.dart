import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:vechile_dispatch_app/Widget_Screen/UserScreen/userRagister_Screen.dart';
import '../../Componants_Widget/customElevated_Button.dart';
import '../../Componants_Widget/custom_textfield.dart';
import '../../Constants/Constants.dart';
import '../../Constants/Utils.dart';
import '../../DB/shere_Prefrences..dart';
import '../Admin_list_Screen/adminHome_Screen.dart';
import '../AdminScreen/adminRegister_Screen.dart';
import 'Bottom_Page.dart';




class Login extends StatefulWidget{
  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {

  bool isPasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String,Object>();
  bool isLoading = false;

  _onSubmit() async {
    _formKey.currentState!.save();
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: _formData["email"].toString(),
          password: _formData["password"].toString());

      if (userCredential.user != null) {
        setState(() {
          isLoading = false;
        });
        FirebaseFirestore.instance.collection('user')
            .doc(userCredential.user!.uid)
            .get()
            .then((value) {
          if (value['type'] == 'parent') {
            if (_formData["email"] == "admin@gmail.com" &&
                _formData["password"] == "admin@8080") {
              MySharedPrefference.saveUserType("parent");
              goTo(context, Admin_List_user());
            } else {
              Utils().showError("You are not admin");
            }
          } else {
            MySharedPrefference.saveUserType("child");
            goTo(context, BottomPage());
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        Utils().showError("No user found for that email.");
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Utils().showError("Wrong password provided for that user.");
        print('Wrong password provided for that user.');
      }
    }
    print('Email: ${_formData["email"]}');
    print('Password: ${_formData["password"]}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome..",
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white24,
      ),
      body:Stack(
        children: [
          isLoading
          ?progressIndicator(context)
          :SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff000000),
                    Color(0x88434343),
                    Color(0xff000000),
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 16),
                child: Form(
                  key:_formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                          textInputAction:TextInputAction.next,
                          keyboardtype:TextInputType.emailAddress,
                          hintText: "Enter Email",prefix:Icon(Icons.email_outlined,
                          color:Colors.white24),
                          onsave:(email){
                            _formData["email"] = email??"";
                          },
                          validate:(email){
                            if(email!.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)){
                              return "Enter a valid Email";
                            }
                            else if(email.length<5){
                              return "Enter valid Email";
                            }
                            else if(!email.contains('@')){
                              return "Enter Correct Email missing @";
                            }
                            else{
                              return null;
                            }
                          }
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        textInputAction:TextInputAction.next,
                        keyboardtype:TextInputType.emailAddress,
                        hintText: "Enter Password",isPassword:isPasswordShown,
                        prefix:Icon(Icons.key_outlined,
                          color:Colors.white24,),
                        onsave:(password){
                          _formData["password"] = password??"";
                        },

                        validate:(password){
                          if(password!.isEmpty){
                            return "Password is Required";
                          }
                          else if(password.length<6){
                            return "create a strong Password";
                          }
                          else{
                            return null;
                          }
                        },
                        suffix:IconButton(onPressed: (){
                          setState((){
                            isPasswordShown =! isPasswordShown;
                          });
                        },
                          icon:isPasswordShown
                              ?Icon(Icons.visibility_off,color: Colors.white24)
                              :Icon(Icons.visibility,color:Colors.white24),
                        ),

                      ),
                      SizedBox(height: 35),
                      CustomElevatedButton(
                        title: "Login",
                        onPressed: () {
                          if(_formKey.currentState!.validate());
                          _onSubmit();
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: Text(
                              "Forget Password",
                              style: GoogleFonts.lato(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            child: TextButton(
                              child: Text(
                                "Click here",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white24,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){
                            return RagisterChild();
                          }));
                        },
                        child: Container(
                          color:Colors.white38,
                          height:45,width:double.infinity,
                          child: Card(elevation:3,shadowColor:Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(left:80,top:6),
                              child: Text(
                                "Register as Child",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,MaterialPageRoute(builder:(context){
                            return RegisterParent();
                          }));
                        },
                        child: Container(
                          color:Colors.white38,
                          height:45,width:double.infinity,
                          child: Card(elevation:3,shadowColor:Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(left:80,top:6),
                              child: Text(
                                "Register as Parent",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white24,
                                ),
                              ),
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
        ],
      ),
      resizeToAvoidBottomInset:false,
    );
  }
}
