import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mychat_app/Utils/prefs.dart';

import '../Utils/constsntutils.dart';
import '../models/id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();



   @override
  void initState() {
   super.initState();
   init();

  }

  void checkValues(String status){
     String email=emailController.text.trim();
     String password=passwordController.text.trim();

     if(email == "" || password ==""){
       print("enter all values");
     }
     else{
       signUp(email,password,status);
     }
   }
   void signUp(String email, String password, String status)async {
     UserCredential? credential;
     try {
       credential = status=="1"? await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password): await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
     } on FirebaseAuthException catch (ex) {
       print(ex.code.toString());
     }

     if (credential != null) {
       String uid = credential.user!.uid;
       UserModel newUser = UserModel(
         uid: uid,
         email: email,
         fullname: "",
       );
       await FirebaseFirestore.instance.collection("users").doc(uid).set(
           newUser.toMap()).
       then((value) {
         print("new user created");
         var Email = credential?.user?.email!;
         var uid = credential?.user?.uid;

         preferences?.setString(ConstantUtils.Email, Email!);
         preferences?.setString(ConstantUtils.Uid, uid!);
         Navigator.push(context, MaterialPageRoute(builder: (context) => const MyFirstPage()),);

       });
     }



   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(40),
          children: [
            TextField(
          controller: emailController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
          ),
        ),

            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),

            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Sign in'),
                  onPressed: () {


                    checkValues("1");

                  },
                )
            ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Does not have account?'),
            TextButton(
              child: const Text(
                'Sign up',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                checkValues("2"); //signup screen
              },
            )

          ],
        ),
        ]
      ),
    )
    );
  }
}



