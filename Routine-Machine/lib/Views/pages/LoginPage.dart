import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/Constants.dart' as Constants;
import '../components/custom_route.dart';
import 'package:routine_machine/Views/pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  static const routeName = '/auth';
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _loginUser(LoginData loginData) async {
    if (_formKey.currentState.validate()) {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: loginData.name,
        password: loginData.password,
      ))
          .user;

      if (user != null) {
        return null;
      } else {
        return null;
      }
    }
    return 'Invalid email or password.';
  }

  Future<String> _registerUser(LoginData loginData) async {
    if (_formKey.currentState.validate()) {
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: loginData.name,
        password: loginData.password,
      ))
          .user;

      return null;
    }
    return "Invalid email or password.";
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Routine Machine',
      logo: 'assets/images/rmlogo.png',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      loginProviders: null,
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
      },
      onSignup: (loginData) async {
        print('Sign Up');
        print('Email: ${loginData.name}');
        print('Password: ${loginData.password}');

        return _registerUser(loginData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(FadePageRoute(
          builder: (context) => HomePage(),
        ));
      },
      onRecoverPassword: null,
      showDebugButtons: true,
    );
  }
}
