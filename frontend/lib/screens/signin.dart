import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/authentication.dart';
import 'package:frontend/screens/signup.dart';
import 'package:frontend/utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../utils/colors.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _message = '';

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult = await _auth.signInWithCredential(credential);
        final user = authResult.user;

        if (user != null) {
          // Google Sign-In successful
          setState(() {
            _message = 'Sign-in successful!';
          });

          // Navigate to the next screen or perform any required actions
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavScreen(),
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _message = 'Error: ${e.toString()}';
      });
    }
  }

  Future<void> _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        _message = 'Sign-in successful!';
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavScreen(),
        ),
      );
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
              'Sign In ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryDark,
                fontSize: 35.48,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16,),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Forgot Password?',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RecoverAccountScreen()),
                        );
                      },
                  ),
                ],
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryDark),
                onPressed: _signIn,
                child: const Text("Sign In"),
              ),
            ),
            const SizedBox(height: 30),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Don\'t have an account? ',
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
                    text: 'Sign Up',
                    style: const TextStyle(
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
                          MaterialPageRoute(builder: (context) => const AuthScreen()),
                        );
                      },
                  ),
                ],
              ),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 30),
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
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _signInWithGoogle, // Trigger Google Sign-In
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.white, // Set the background color to white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/google-logo.jpeg',
                    height: 60,
                    width: 60,
                   
                  ),
                  SizedBox(width: 10),
                  // Text('Sign In with Google', ),
                ],
              ),
            ),

            Text(_message),
          ],
        ),
      ),
    );
  }
}
