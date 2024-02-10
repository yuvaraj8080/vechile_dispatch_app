import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Chat_Module/Chat_Screen.dart';
import '../../Constants/Constants.dart';
import '../../Constants/Utils.dart';
import '../UserScreen/Main_Login_Screen.dart';
class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child:Column(children:[
            DrawerHeader(child: Container()

            ),
            ListTile(
                title:TextButton(onPressed:()async{
                  try{
                    await FirebaseAuth.instance.signOut();
                    goTo(context,Login());
                  }
                  on FirebaseAuthException catch(e){
                    Utils().showError(e.toString());
                  }
                },
                    child:Text("SIGN OUT"))
            )
          ])
      ),
      appBar:AppBar(title:Text("LIST OF USER",style:GoogleFonts.roboto(fontSize:20,
          fontWeight:FontWeight.bold)),
        backgroundColor:Colors.white24,elevation:3,
      ),
      body:StreamBuilder(
          stream:FirebaseFirestore.instance.collection("user")
              .where("type",isEqualTo: "child")
              .where("guardiantEmail",isEqualTo:FirebaseAuth.instance.currentUser?.email)
              .snapshots(),
          builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

            if(!snapshot.hasData){
              return progressIndicator(context);
            }
            return ListView.builder(

                itemCount:snapshot.data!.docs.length,
                itemBuilder:(BuildContext context ,int index){
                  final d = snapshot.data!.docs[index];
                  return Padding(padding:const EdgeInsets.all(8),
                      child:Container(
                          child:Card(
                            elevation:2,shadowColor:Colors.white,
                            child: ListTile(
                              onTap:(){

                                Navigator.push(context,MaterialPageRoute(builder: (context){
                                  return ChattingScreen(
                                      currentUserId: FirebaseAuth.instance.currentUser!.uid,
                                      friendId:d.id,
                                      friendName:d["name"]);
                                }));
                              },
                                title:Text(d["name"])
                            ),
                          )
                      )
                  );
                });
          }
      ),
    );
  }
}

