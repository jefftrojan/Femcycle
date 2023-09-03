import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/authentication.dart';
import 'package:frontend/screens/signup.dart';

import '../utils/colors.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _message = '';

  void _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        _message = 'Sign-in successful!';
      });
    } catch (e) {
      setState(() {
        _message = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sign In ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primary,
                fontSize: 35.48,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(
              height: 50,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16,),
            Text.rich(
              TextSpan(
                children: [
                  
                    TextSpan(
                      text: 'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        // decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RecoverAccountScreen()),
                          );
                        }),
                ],
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 16),
            Container(
              width:double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: primary),
                
                onPressed: _signIn,
                child: Text("Sign In"),
              ),
            ),
            SizedBox(height: 30),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Don\'t have an acount? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.19,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: ' ',
                    style: TextStyle(
                      color: Color(0xFFD87234),
                      fontSize: 14.19,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AuthScreen()),
                          );
                        }),
                ],
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1.0,
                    color: Colors.black,
                    margin: EdgeInsets.only(right: 8.0),
                  ),
                ),
                Text("Sign in With"),
                Expanded(
                  child: Container(
                    height: 1.0,
                    color: Colors.black,
                    margin: EdgeInsets.only(left: 8.0),
                  ),
                ),
              ],
            ),
            Text(_message),
          ],
        ),
      ),
    );
  }
}