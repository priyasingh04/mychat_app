import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../Utils/constsntutils.dart';
import '../Utils/prefs.dart';
import 'ChatScreen2.dart';
class MySecondPage extends StatefulWidget {
  const MySecondPage({Key? key}) : super(key: key);

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {



  @override
  Widget build(BuildContext context) {
    var width=  MediaQuery.of(context).size.width;
    return Container(
          height: MediaQuery.of(context).size.height-100,
          width: width,
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> usersnapshot) {
                if (usersnapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      child: const Center(child: CircularProgressIndicator()));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: usersnapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = usersnapshot.data!.docs[index];

                        if (document.id == preferences?.getString(ConstantUtils.Uid)) {
                          return Container(height: 0);
                        }

                        return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MyThirdPage(document.id)));
                        },
                          child:

                          Column(children: [const SizedBox(height: 10,),
                          Container(
                            color: Colors.grey,
                           width: width,
                            height: 40,
                            child: Column(
                              children: [
                                Text(document.id,),
                                Text(document.get('email')),

                              ],
                            ),
                          )],));
                      },
                    ),
                  );
                }
              },)




        );

  }
}

