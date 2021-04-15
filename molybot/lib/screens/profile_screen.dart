import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/auth_form.dart';
import '../widgets/profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(
    String email,
    String username,
    String password,
    bool isLogin,
    BuildContext ctx,
  )async {
    UserCredential userCredential;

    try {
      if(isLogin){
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Logged in successfully!"),
        ));
      }else{
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password);

        await FirebaseFirestore.instance
        .collection("users")
        .doc(userCredential.user.uid)
        .set({
          //"username": username,
          "email": email,
          "btcAlarm": 0,
          "ethAlarm": 0
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("Profile created"),
        ));
      }
    } on PlatformException catch (err) {
        var msg = "An error occured, please check your credentials!";

        if(err.message != null){
          msg = err.message;
        }
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(msg),));
    } catch(err){
      print(err);
    }

    
  }  

  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot){
        if(userSnapshot.hasData){
          return Profile();
        }else{
          return AuthForm(_submitAuthForm);
        }
      });
  }
}