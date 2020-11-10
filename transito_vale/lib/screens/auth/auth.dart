import 'package:flutter/material.dart';
import 'package:transito_vale/screens/background_painter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
              child: CustomPaint(
            painter: BackgroundPainter(
              animation: _controller.view,
            ),
          )),
          Center(
            child: RaisedButton(
              onPressed: () {
                _controller.forward(from: 0);
              },
              child: Text('Animetad'),
            ),
          )
        ],
      ),
    );
  }
}
