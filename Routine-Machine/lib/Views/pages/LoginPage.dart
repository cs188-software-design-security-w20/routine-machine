// import 'dart:html';
import 'dart:io';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routine_machine/api/APIWrapper.dart';
import '../../constants/Constants.dart' as Constants;
import '../components/custom_route.dart';
import 'package:routine_machine/Views/pages/HomePage.dart';
import 'ScanQRPage.dart';
import 'SetUserInfoPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io' show Platform;

FirebaseAuth _auth = FirebaseAuth.instance;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
enum authProblems {
  UserNotFound,
  PasswordNotValid,
  NetworkError,
  Unknown,
}
enum SignInType {
  signUp,
  logIn,
}

class LoginPage extends StatefulWidget {
  static const routeName = '/auth';
  final storage = new FlutterSecureStorage();
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  APIWrapper apiWrapper;
  User user;
  String key;
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
  SignInType _signInType = SignInType.logIn;

  bool _keyExistsOnDevice() {
    // TODO: implement this
    return key != null; // set to true to bypass qr scanner page
  }

  Future<String> _loginUser(LoginData loginData) async {
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: loginData.name,
        password: loginData.password,
      )
          .then((user) {
        var m = user;
        setState(() {
          this.user = user.user;
          print("Login: ${this.user}");
        });
        _auth.setPersistence(Persistence.LOCAL);
        print("Auth completed");
        return null;
      });
    } catch (e) {
      print('Error occured during login $e');
      authProblems errorType;
      String errorMessage;
      if (Platform.isAndroid) {
        switch (e.message) {
          case 'There is no user record corresponding to this identifier. The user may have been deleted.':
            errorType = authProblems.UserNotFound;
            errorMessage =
                "There is no user record corresponding to this identifier.";
            break;
          case 'The password is invalid or the user does not have a password.':
            errorType = authProblems.PasswordNotValid;
            errorMessage =
                "The password is invalid or the user does not have a password.";
            break;
          case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            errorType = authProblems.NetworkError;
            errorMessage =
                "A network error (such as timeout, interrupted connection or unreachable host) has occurred.";
            break;
          // ...
          default:
            errorType = authProblems.Unknown;
            errorMessage = "Error found, please try again.";
            print('Case ${e.message} is not yet implemented');
        }
      } else if (Platform.isIOS) {
        switch (e.code) {
          case 'user-not-found':
            errorType = authProblems.UserNotFound;
            errorMessage =
                "There is no user record corresponding to this identifier.";
            break;
          case 'wrong-password':
            errorType = authProblems.PasswordNotValid;
            errorMessage =
                "The password is invalid or the user does not have a password.";
            break;
          // ...
          default:
            errorType = authProblems.Unknown;
            errorMessage = "Error found, please try again.";
            print('Case ${e.message} is not yet implemented');
        }
      }
      return 'Error: $errorMessage';
    }
  }

  Future<String> _registerUser(LoginData loginData) async {
    _auth
        .createUserWithEmailAndPassword(
      email: loginData.name,
      password: loginData.password,
    )
        .then((user) {
      setState(() {
        this.user = user.user;
      });
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Routine Machine',
      logo: 'assets/images/rmlogo-new.png',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      hideForgotPasswordButton: true,
      loginProviders: [],
      messages: LoginMessages(
        usernameHint: 'Email',
        passwordHint: 'Password',
        // confirmPasswordHint: 'Confirm',
        loginButton: 'Log In',
        signupButton: 'Sign Up',
        // forgotPasswordButton: 'Forgot password?',
        // recoverPasswordButton: 'HELP ME',
        goBackButton: 'Back to Log In',
        confirmPasswordError: 'Not match!',
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
          letterSpacing: 4,
        ),
        beforeHeroFontSize: 22,
        afterHeroFontSize: 12,
      ),
      emailValidator: (value) {
        if (!value.contains('@') ||
            !value.endsWith('.com') &&
                !value.endsWith('.edu') &&
                !value.endsWith('.net')) {
          return "Email must contain '@' and end with '.com/edu/net'";
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
        setState(() {
          _signInType = SignInType.logIn;
        });
        return _loginUser(loginData);
      },
      onSignup: (loginData) async {
        print('Sign Up');
        print('Email: ${loginData.name}');
        print('Password: ${loginData.password}');
        setState(() {
          _signInType = SignInType.signUp;
        });
        return _registerUser(loginData);
      },
      onSubmitAnimationCompleted: () {
        // no error found, login success
        // redirect to home page
        print("On login success: ${this.user}");
        if (_signInType == SignInType.signUp) {
          Navigator.of(context).pushReplacement(FadePageRoute(
            builder: (context) => SetUserInfoPage(user: this.user),
          ));
        } else if (_signInType == SignInType.logIn) {
          APIWrapper api = APIWrapper();
          api.setUser(this.user);
          api.cse.hasKeyPair().then((value) => {
                print("hasKeyPair: ${this.user}"),
                if (value)
                  {
                    // TODO: implement this function above
                    Navigator.of(context).pushReplacement(FadePageRoute(
                        builder: (context) => HomePage(user: this.user))),
                  }
                else
                  {
                    // go to scan page
                    Navigator.of(context).pushReplacement(FadePageRoute(
                        builder: (context) => ScanQRPage(user: this.user))),
                  }
              });
        }
      },
      onRecoverPassword: null,
      showDebugButtons: false,
    );
  }
}
