import 'package:flutter/material.dart';
import 'package:routine_machine/RoutineWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
bool _success;
String _userEmail;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  RoutineWidget r = RoutineWidget();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Routine Machine",
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('A Error: ${snapshot.error.toString()}');
            return Text('Something went wrong :(');
          } else if (snapshot.hasData) {
            return MainDashboard(title: "Main Dashboard");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class MainDashboard extends StatefulWidget {
  MainDashboard({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title), actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return TextButton(
              child: const Text('Sign Out'),
              // textColor: Theme.of(context).buttonColor,
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.resolveWith((states) => Colors.white),
              ),
              onPressed: () async {
                final User user = await _auth.currentUser;
                if (user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('No one has signed in'),
                  ));
                  return;
                }

                await _auth.signOut();
                final String uid = user.uid;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(uid + ' has successfully signed out'),
                ));
              },
            );
          }),
        ]),
        body: Builder(builder: (BuildContext context) {
          return ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                _RegisterEmailSection(),
              ]);
        }));
  }
}

class _RegisterEmailSection extends StatefulWidget {
  final String title = 'Registration';

  @override
  State<StatefulWidget> createState() => _RegisterEmailSectionState();
}

class _RegisterEmailSectionState extends State<_RegisterEmailSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _register();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(_success == null
                  ? ''
                  : (_success
                      ? 'Successfully registered ' + _userEmail
                      : 'Registration failed')),
            )
          ],
        ),
      ),
    );
  }

  void _register() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  void _signInWithEmailAndPassword() async {
    final User user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    bool _success;
    String _userEmail;
    @override
    Widget build(BuildContext context) {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: const Text('Test sign in with email and password'),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _signInWithEmailAndPassword();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _success == null
                    ? ''
                    : (_success
                        ? 'Successfully signed in ' + _userEmail
                        : 'Sign in failed'),
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      );
    }

    @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }
  }
}
