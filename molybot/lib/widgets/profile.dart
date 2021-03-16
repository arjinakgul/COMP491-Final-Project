import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatelessWidget {

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    
  }

  @override
  Widget build(BuildContext context) {
    return Center(

      child: Container(
        color: Colors.pink,
        child: Center(
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black)
              ),
              onPressed: _signOut, 
              child: Text("Log out!", style: TextStyle(color: Colors.white))),
        ),
      ),
    );
  }
}