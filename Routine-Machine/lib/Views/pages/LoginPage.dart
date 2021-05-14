// import 'dart:html';
import 'dart:io';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/Constants.dart' as Constants;
import '../components/custom_route.dart';
import 'package:routine_machine/Views/pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io' show Platform;


FirebaseAuth _auth = FirebaseAuth.instance;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class LoginPage extends StatelessWidget {
  static const routeName = '/auth';
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
  Future<String> _loginUser(LoginData loginData) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: loginData.name,
        password: loginData.password,
      ))
          .user;
    } catch (e) {
      authProblems errorType;
      if (Platform.isAndroid) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = authProblems.UserNotFound;
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = authProblems.PasswordNotValid;
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = authProblems.NetworkError;
            break;
          // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      } else if (Platform.isIOS) {
        switch (e.code) {
          case 'user-not-found':
            errorType = authProblems.UserNotFound;
            break;
          case 'wrong-password':
            errorType = authProblems.PasswordNotValid;
            break;
          // ...
          default:
            print('Case ${e.message} is not yet implemented');
        }
      }
      return 'Error: $errorType';
    }

    // if (user != null) {
    //   return null;
    // } else {
    //   return null;
    // }
  }

  Future<String> _registerUser(LoginData loginData) async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: loginData.name,
      password: loginData.password,
    ))
        .user;

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Routine Machine',
      logo: 'assets/images/rmlogo.png',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      loginProviders: Platform.isIOS
          ? [
              LoginProvider(
                icon: FontAwesomeIcons.apple,
                callback: () async {
                  final credential = await SignInWithApple.getAppleIDCredential(
                    scopes: [
                      AppleIDAuthorizationScopes.email,
                      AppleIDAuthorizationScopes.fullName,
                    ],
                  );
                  print(credential);
                },
              ),
            ]
          : [],
      messages: LoginMessages(
        usernameHint: 'Email',
        passwordHint: 'Password',
        // confirmPasswordHint: 'Confirm',
        loginButton: 'Log In',
        signupButton: 'Sign Up',
        forgotPasswordButton: 'Forgot password?',
        // recoverPasswordButton: 'HELP ME',
        goBackButton: 'Back to Log In',
        confirmPasswordError: 'Not match!',

        // recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
        // recoverPasswordDescription:
        //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        // recoverPasswordSuccess: 'Password rescued successfully',
        // flushbarTitleError: 'Oh no!',
        // flushbarTitleSuccess: 'Succes!',
      ),
      theme: LoginTheme(
        primaryColor: Color(0xffB057F5),
        accentColor: Color(0xffB057F5),
        errorColor: Colors.deepOrange,
        pageColorLight: Colors.white,
        pageColorDark: Colors.white,
        titleStyle: TextStyle(
          color: Color(0xffB057F5),
          fontFamily: 'SF Pro Rounded',
        ),
        beforeHeroFontSize: 22,
        afterHeroFontSize: 12,
      ),
      emailValidator: (value) {
        if (!value.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value.length < 6) {
          return 'Password must be at least 6 characters.';
        }
        return null;
      },
      onLogin: (loginData) async {
        print('Login');
        print('Email: ${loginData.name}');
        print('Password: ${loginData.password}');

        return _loginUser(loginData);
        //return _loginUser(loginData);
      },
      onSignup: (loginData) async {
        print('Sign Up');
        print('Email: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _registerUser(loginData);
      },
      onSubmitAnimationCompleted: () {
        // no error found, login success
        // redirect to home page
        Navigator.of(context).pushReplacement(FadePageRoute(
          builder: (context) => HomePage(),
        ));
      },
      onRecoverPassword: null,
      showDebugButtons: false,
    );
  }
}
