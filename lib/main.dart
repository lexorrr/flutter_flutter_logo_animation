import 'package:flutter/material.dart';
import 'dart:math' as math;

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Logo Animation'),
      ),
      body: Center(
        child: const FLSpinner(),
      ),
    );
  }
}

class RotatingLogo extends AnimatedWidget {
  final Animation _controller;
  const RotatingLogo({
    required Animation controller
  }) : _controller = controller, super(listenable: controller);

  static const _fullRotation = 2 * math.pi;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _controller.value * _fullRotation,
      child: const FlutterLogo(
        size: 80,
      ),
    );
  }
}

class FLSpinner extends StatefulWidget {
  const FLSpinner();

  @override
  _FLSpinnerState createState() => _FLSpinnerState();
}

class _FLSpinnerState extends State<FLSpinner>
  with TickerProviderStateMixin{
  late final AnimationController _controller;
  late final CurvedAnimation _curved;
  late final ReverseAnimation _reverse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn
    );

    // _reverse = ReverseAnimation(_controller);
    _reverse = ReverseAnimation(_curved);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotatingLogo(controller: _reverse);
  }
}


