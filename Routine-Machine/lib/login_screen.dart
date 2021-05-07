import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';
import 'custom_route.dart';
import 'dashboard_screen.dart';
import 'users.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'The password does not match';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Routine Machine',
      logo: '../assets/images/rmlogo.png',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,

      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          callback: () async {
            print('start google sign in');
            await Future.delayed(loginTime);
            print('stop google sign in');
            return null;
          },
        ),
      ],

      //loginAfterSignUp: false,
      // // hideForgotPasswordButton: true,
      // // hideSignUpButton: true,
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

          //letterSpacing: 1,
        ),
        beforeHeroFontSize: 22,
        afterHeroFontSize: 12,
        // bodyStyle: TextStyle(
        //   fontStyle: FontStyle.italic,
        //   decoration: TextDecoration.underline,
        // ),
        // textFieldStyle: TextStyle(
        //   color: Colors.orange,
        //   shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
        // ),
        // buttonStyle: TextStyle(
        //   fontWeight: FontWeight.w800,
        //   color: Colors.yellow,
        // ),
        // cardTheme: CardTheme(
        //   color: Colors.yellow.shade100,
        //   elevation: 5,
        //   margin: EdgeInsets.only(top: 15),
        //   shape: ContinuousRectangleBorder(
        //       borderRadius: BorderRadius.circular(100.0)),
        // ),
        // inputTheme: InputDecorationTheme(
        //   filled: true,
        //   fillColor: Colors.purple.withOpacity(.1),
        //   contentPadding: EdgeInsets.zero,
        //   errorStyle: TextStyle(
        //     backgroundColor: Colors.orange,
        //     color: Colors.white,
        //   ),
        //   labelStyle: TextStyle(fontSize: 12),
        //   enabledBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
        //     borderRadius: inputBorder,
        //   ),
        //   focusedBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
        //     borderRadius: inputBorder,
        //   ),
        //   errorBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(color: Colors.red.shade700, width: 7),
        //     borderRadius: inputBorder,
        //   ),
        //   focusedErrorBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(color: Colors.red.shade400, width: 8),
        //     borderRadius: inputBorder,
        //   ),
        //   disabledBorder: UnderlineInputBorder(
        //     borderSide: BorderSide(color: Colors.grey, width: 5),
        //     borderRadius: inputBorder,
        //   ),
        // ),
        // buttonTheme: LoginButtonTheme(
        //   splashColor: Colors.purple,
        //   backgroundColor: Colors.pinkAccent,
        //   highlightColor: Colors.lightGreen,
        //   elevation: 9.0,
        //   highlightElevation: 6.0,
        //   shape: BeveledRectangleBorder(
        //     borderRadius: BorderRadius.circular(10),
        //   ),

        //   // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        //   // shape: CircleBorder(side: BorderSide(color: Colors.green)),
        //   // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        // ),
      ),
      emailValidator: (value) {
        if (!value.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) {
        print('Login info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSignup: (loginData) {
        print('Signup info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(FadePageRoute(
          builder: (context) => DashboardScreen(),
        ));
      },
      onRecoverPassword: (name) {
        print('Recover password info');
        print('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
      showDebugButtons: true,
    );
  }
}
