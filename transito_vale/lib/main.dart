import 'package:flutter/material.dart';
import 'package:transito_vale/screens/auth/auth.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

import 'screens/auth/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
        child: MaterialApp(
      title: 'Material App',
      home: AuthScreen(),
    ));
  }
}
