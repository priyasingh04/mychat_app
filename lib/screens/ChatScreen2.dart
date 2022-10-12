import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Utils/constsntutils.dart';

import '../Utils/prefs.dart';
import '../models/chatmodel.dart';
class MyThirdPage extends StatefulWidget {
  final String id;
  const MyThirdPage(this.id, {Key? key}) : super(key: key);

  @override
  State<MyThirdPage> createState() => _MyThirdPageState();
}





class _MyThirdPageState extends State<MyThirdPage> {
  TextEditingController textEditingController = TextEditingController();
  String groupChatId ="";



  Future sendMessage() async{
    var currentId= preferences?.getString(ConstantUtils.Uid);
    if ((preferences?.getString(ConstantUtils.Uid)??"").compareTo(widget.id) > 0) {
      groupChatId = "$currentId-${widget.id}";
    } else {
      groupChatId = "${widget.id}-$currentId";
    }
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("message")
        .doc(groupChatId);

    ChatMessages chatMessages = ChatMessages(idTo:widget.id ,idFrom: preferences?.getString(ConstantUtils.Uid),content: textEditingController.text,timestamp: DateTime.now().millisecondsSinceEpoch.toString());
    await FirebaseFirestore.instance.runTransaction((transaction) async{
      transaction.set(documentReference, chatMessages.toMap());
    });

  }
  Future receivedMessage() async{
    var currentId = preferences?.getString(ConstantUtils.Uid);
    if ((preferences?.getString(ConstantUtils.Uid)??"").compareTo(widget.id) > 0) {
      groupChatId = "$currentId-${widget.id}";
    } else {
      groupChatId = "${widget.id}-$currentId";
    }
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("message")
        .doc(groupChatId)
    .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    ChatMessages chatMessages = ChatMessages(idTo:widget.id ,idFrom: preferences?.getString(ConstantUtils.Uid),content: textEditingController.text,timestamp: DateTime.now().millisecondsSinceEpoch.toString());
    await FirebaseFirestore.instance.runTransaction((transaction) async{
      transaction.set(documentReference, chatMessages.toMap());
    });

  }







  @override
  Widget build(BuildContext context) {
    var currentId = preferences?.getString(ConstantUtils.Uid);
    if ((preferences?.getString(ConstantUtils.Uid)??"").compareTo(widget.id) > 0) {
      groupChatId = "$currentId-${widget.id}";
    } else {
      groupChatId = "${widget.id}-$currentId";
    }
    return SafeArea(child:
      Scaffold(

      body:SizedBox(
        width:MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-50,
        child: Column(
          children: [
          // width:MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height-50,

     StreamBuilder(
         stream: FirebaseFirestore.instance.collection('message').doc(groupChatId).collection(groupChatId).snapshots(),
         builder: (ctx, AsyncSnapshot<QuerySnapshot> usersnapshot) {
           if (usersnapshot.connectionState == ConnectionState.waiting) {
             return Container(
                 child: const Center(child: CircularProgressIndicator()));
           } else {
             return Expanded(
               child: ListView.builder(
                   itemCount: usersnapshot.data?.docs.length,
                   itemBuilder: (context, index) {
                     // var query = usersnapshot.data?.docs;
                     // print(query);
                     // query?.elementAt(index).data();
                     DocumentSnapshot document = usersnapshot.data!.docs[index]
                      as DocumentSnapshot<Object?>;
                     print(document.get("content"));


                     return SizedBox(
                       height: 40, width: MediaQuery.of(context).size.width,
                       child: Text("message content" + document.get("content")),
                     );
                   })
             );
           }
         }


     ),
          Align(alignment: Alignment.bottomCenter,
          child:

            Row(


               children: [
               const Padding(padding: EdgeInsets.all(20),),


           Flexible(
           child: TextField(
           // focusNode: FocusNode(),
           textInputAction: TextInputAction.send,
           keyboardType: TextInputType.text,
           textCapitalization: TextCapitalization.sentences,
           controller: textEditingController,
           decoration: const InputDecoration(hintText: 'write here...'),

           )),
           Container(
           margin: const EdgeInsets.only(left: 4),
           decoration: BoxDecoration(
           color: Colors.blue,
           borderRadius: BorderRadius.circular(30),
           ),
           child: IconButton(
           onPressed: () {
           sendMessage();
           },
           icon: const Icon(Icons.send_rounded),
           color: Colors.white,
           ),
           ),


           ],
            )
           )





            ]
    ),
      )
    )

    );
  }
}