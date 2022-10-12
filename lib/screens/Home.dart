import 'package:flutter/material.dart';

import 'package:mychat_app/screens/ChatScreen.dart';

import '../Utils/constsntutils.dart';
import '../Utils/prefs.dart';


class MyFirstPage extends StatefulWidget {
  const MyFirstPage({Key? key}) : super(key: key);

  @override
  State<MyFirstPage> createState() => _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> {
   int selectedIndex = 0;



  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  var email = "";
  var uid = "";

  @override
  void initState() {
    super.initState();
    init();
    Future.delayed(const Duration(milliseconds: 5), () {

      setState(() {

        email=preferences?.getString(ConstantUtils.Email) ?? "priti";
        uid=preferences?.getString(ConstantUtils.Uid) ?? "priti";

      });

    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      body:
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            selectedIndex ==0?Column(
              children: [


            Text("uid:"+uid),
            SizedBox(height: 40,),
            Text("email"+email),
              ],
            ): const MySecondPage(),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(

      items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(

    icon: Icon(Icons.home),
    label: 'Home',
    backgroundColor: Colors.red,
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.chat),
    label: 'Chat',
    backgroundColor: Colors.green,
    ),

    ],
        currentIndex: selectedIndex,

    selectedItemColor: Colors.amber[800],
    onTap: _onItemTapped,
      )
      )

    );
  }
}


