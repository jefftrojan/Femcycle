import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/screens/location.dart';
import 'package:frontend/screens/signin.dart';

import '../utils/colors.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _message = '';
  

  void _signUp() async {
  try {
    if (_passwordController.text == _confirmPasswordController.text) {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Store user email in Firestore
      await FirebaseFirestore.instance.collection('users').add({
        'email': _emailController.text,
      });

      setState(() {
        _message = 'Sign-up successful!';
      });

      // Navigate to the ChatScreen after successful sign-up
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Stores(), // Replace with the actual ChatScreen class
        ),
      );
    } else {
      setState(() {
        _message = 'Passwords do not match.';
      });
    }
  } catch (e) {
    setState(() {
      _message = 'Error: ${e.toString()}';
    });
  }
}

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
            const Text(
            'Register on\n Fem Cycle ',
            textAlign: TextAlign.center,
            style: TextStyle(
            color: primary,
            fontSize: 35.48,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w700,
            ),),
            
            const SizedBox(height: 50,),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            SizedBox(
             
              width: double.infinity,
              child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                ),
                onPressed: _signUp,
                child: const Text("Sign Up",),
              ),
            ),
            // Container(
            //   width: double.infinity,
             
            //   child: ElevatedButton(
            //      style: ElevatedButton.styleFrom(
            //       primary:primary,
            //     ),
            //     onPressed: _signIn,
            //     child: Text("Sign In"),
            //   ),
            // ),
            const SizedBox(height: 30),
            Text.rich(
              TextSpan(
              children: [
              const TextSpan(
              text: 'have an acount? ',
              style: TextStyle(
              color: Colors.black,
              fontSize: 14.19,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
              ),
              ),
              const TextSpan(
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
              
              text: 'Sign In',
              style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
              ),    recognizer: TapGestureRecognizer()
          ..onTap = () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignIn()),
              );}
              ),
          
              ],
              ),
              textAlign: TextAlign.right,
              ),
              const SizedBox(height:30),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1.0,
                    color: Colors.black,
                    margin: const EdgeInsets.only(right: 8.0),
                  ),
                ),
                const Text("Sign in With"),
                Expanded(
                  child: Container(
                    height: 1.0,
                    color: Colors.black,
                    margin: const EdgeInsets.only(left: 8.0),
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
