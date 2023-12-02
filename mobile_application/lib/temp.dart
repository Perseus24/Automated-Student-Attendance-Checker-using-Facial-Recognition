import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _hasError = false;
  bool _usernameHasError = false;
  bool _passwordHasError = false;

  _handleFormSubmission() {
    final rand = Random();

    setState(() {
      _hasError = rand.nextBool();
    });

    print('Sumbmitted');
  }

  _handleUsernameChange(String value) {
    setState(() {
      _usernameHasError = value.isEmpty;
    });
  }

  _handlePasswordChange(String value) {
    setState(() {
      _passwordHasError = value.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(10.0).add(const EdgeInsets.only(top: 30.0)),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(children: [
                Text('Large title',
                    style: Theme.of(context).textTheme.headline2),
                Text(
                    'a.',
                    style: Theme.of(context).textTheme.headline5),
              ]),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(children: [
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text('Additional information is placed here')),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Username',
                      errorText: _usernameHasError ? 'Invalid username' : null),
                  onChanged: _handleUsernameChange,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: _passwordHasError ? 'Invalid password' : null),
                  onChanged: _handlePasswordChange,
                ),
                _hasError
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error,
                                  color: Theme.of(context).errorColor),
                              Text('An error occurred!',
                                  style: TextStyle(
                                      color: Theme.of(context).errorColor))
                            ]))
                    : Container()
              ]),
            ),
            Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(children: [
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text('Submit'),
                        onPressed: _handleFormSubmission,
                      )),
                ])),
          ]),
    ));
  }
}