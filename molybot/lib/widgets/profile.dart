import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage('assets/images/molybotBlack.png'),
          ),
          Text(
            "Username",
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Personal Information",
            style: TextStyle(
              fontFamily: 'Source Sans Pro',
              fontSize: 18.0,
              letterSpacing: 2.0,
              color: Colors.pink.shade300,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
            width: 200.0,
            child: Divider(
              color: Colors.white,
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: ListTile(
              leading: Icon(
                Icons.mail_rounded,
                color: Colors.pink,
              ),
              title: Text(
                user.email.toString(),
                style: TextStyle(
                  color: Colors.pink,
                  fontFamily: 'Source Sans Pro',
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          Container(
            child: Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: _signOut,
                child: Text(
                  "Log out!",
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

// child: Container(
//         color: Colors.pink,
//         child: Center(
//           child: ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(Colors.black)
//               ),
//               onPressed: _signOut,
//               child: Text("Log out!", style: TextStyle(color: Colors.white))),
//         ),
//       ),

// Card(
//               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//               child: ListTile(
//                 leading: Icon(
//                   Icons.logout,
//                   color: Colors.pink,
//                 ),
//                 title: Text(
//                   'log out!',
//                   style: TextStyle(
//                     color: Colors.pink.shade900,
//                     fontFamily: 'Source Sans Pro',
//                     fontSize: 20.0,
//                   ),
//                 ),
//               ))
