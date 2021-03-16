import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthForm extends StatefulWidget {

  final void Function(
    String email,
    String username,
    String password,
    bool isLogin,
    BuildContext ctx
  )submitFn;

  AuthForm(this.submitFn);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail ="";
  String _userName ="";
  String _userPassword ="";

  void trySubmit(){
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _isLogin,
        context
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 12,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    key: ValueKey("email"),
                    validator: (value){
                      if(!value.contains("@") || value.isEmpty){
                        return "Email adress is invalid!";
                      }else return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.pink[400]),
                      labelText: "Email Adress"
                    ),
                    onSaved: (value){
                      _userEmail = value;
                    },
                  ),
                  if(!_isLogin)
                    TextFormField(
                      key: ValueKey("username"),
                    validator: (value){
                      if(value.length<8 || value.isEmpty){
                        return "Username should be at least 8 characters!";
                      }else return null;
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.pink[400]),
                      labelText: "Username"
                    ),
                    onSaved: (value){
                      _userName = value;
                    },
                  ),
                  
                  TextFormField(
                    key: ValueKey("password"),
                    validator: (value){
                      if(value.length < 8 || value.isEmpty){
                        return "Password should be at least 8 characters!";
                      }else return null;
                    },
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.pink[400]),
                      labelText: "Password",
                    ),
                    obscureText: true,
                    onSaved: (value){
                      _userPassword = value;
                    },
                  ),
                  SizedBox(
                    height: 12
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent[400],
                      shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),),
                    child: Text(_isLogin ? "Login" : "Signup"),
                    onPressed: trySubmit),
                  TextButton(
                    onPressed: (){
                      setState(() {
                        _isLogin = !_isLogin;
                        
                      });
                    }, 
                    child: Text(
                      _isLogin ? "Create new account" 
                      : "I already have an account",
                      style: TextStyle(color: Colors.pink[400]),))
                ],
              ),
            ),),
        ),
      ),
    );
  }
}