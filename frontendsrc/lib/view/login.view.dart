import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontendsrc/brandkit/colors.dart';
import 'package:frontendsrc/model/cycletrack.model.dart';
import 'package:get/get.dart';
// import 'package:frontendsrc/controllers/login.control.dart';

import '../model/login_register.model.dart';
import '../periodsmain.view.dart';

class LoginView extends StatelessWidget {
  final LoginRegisterModel model;
  final Function(String? email, String? password)? onSubmitted;


  

  LoginView({required this.model, this.onSubmitted});
   final PeriodsModel periodsModel = PeriodsModel(
    currentUsername: "YourUsername",
    today: DateTime.now(), // Replace with your date
    firstDayOfWeek: DateTime.now(), // Replace with your date
    lastDayOfWeek: DateTime.now(), // Replace with your date
  );


  
  Future<bool> submit() async {
    // Implement your submit logic here.
    User? user = FirebaseAuth.instance.currentUser;
    String currentUsername = user != null ? user.displayName ?? 'Guest' : 'Guest';

    if (onSubmitted != null) {
      // Call the onSubmitted function and wait for its result (assuming it returns a boolean).
      final loginSuccessful = await onSubmitted!(model.email, model.password);
      return loginSuccessful;
    }
    return false;
  }

    void handleLoginButtonTap() async {
      bool loginSuccessful = await submit();

      if (loginSuccessful) {

        User? user = FirebaseAuth.instance.currentUser;
        String currentUsername = user != null ? user.displayName ?? 'Guest' : 'Guest';

        Get.off(PeriodsView(periodsModel));
      }
    }

  


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: screenHeight * .12),
            const Text(
              'Fem.Cycle',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            const Text(
              'Welcome,',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * .01),
            Text(
              'Sign in to continue!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            SizedBox(height: screenHeight * .12),
            InputField(
              onChanged: (value) {
                // Update the email property of the model
                model.email = value;
              },
              labelText: 'Email',
              errorText: model.emailError,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autoFocus: true,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                // Update the password property of the model
                model.password = value;
              },
              onSubmitted: (val) => submit(),
              labelText: 'Password',
              errorText: model.passwordError,
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Handle forgot password logic here.
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * .075,
            ),
            FormButton(
              text: 'Log In',
              onPressed: submit,
            ),
            SizedBox(
              height: screenHeight * .05,
            ),
            TextButton(
              onPressed: () {
                // Handle navigation to the registration screen here.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        RegisterView(model: model, onSubmitted: onSubmitted),
                  ),
                );
              },
              child: RichText(
                text: const TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterView extends StatelessWidget {
  final LoginRegisterModel model;
  final Function(String? email, String? password)? onSubmitted;

  RegisterView({required this.model, this.onSubmitted});

  void submit() {
    // Implement your registration logic here.
    if (onSubmitted != null) {
      onSubmitted!(model.email, model.password);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ListView(
          children: [
            // SizedBox(height: screenHeight * .12),
            const Text(
              'Create Account,',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * .01),
            Text(
              'Sign up to get started!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            SizedBox(height: screenHeight * .12),
            InputField(
              onChanged: (value) {
                // Update the email property of the model
                model.email = value;
              },
              labelText: 'Email',
              errorText: model.emailError,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autoFocus: true,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                // Update the password property of the model
                model.password = value;
              },
              labelText: 'Password',
              errorText: model.passwordError,
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                // Update the confirmPassword property of the model
                model.confirmPassword = value;
              },
              onSubmitted: (value) => submit(),
              labelText: 'Confirm Password',
              errorText: model
                  .passwordError, // Use the same error text as the password
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: screenHeight * .075,
            ),
            FormButton(
              text: 'Sign Up',
              onPressed: () {
                // On successful registration, store user data and redirect to the login screen.
                // Implement your logic here to store user data.
                // For now, let's navigate back to the login screen.
                Get.off(LoginView(model: LoginRegisterModel()));
              },
            ),
            SizedBox(
              height: screenHeight * .05,
            ),
            TextButton(
              onPressed: () {
                // Handle navigation back to the login screen here.
                Get.off(LoginView(model: LoginRegisterModel()));
              },
              child: RichText(
                text: const TextSpan(
                  text: "Have an account? ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
