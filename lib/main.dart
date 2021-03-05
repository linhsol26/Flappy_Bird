import 'package:flutter/material.dart';
import 'package:flappy_bird/play.dart';
import 'package:flappy_bird/utils/bird_position.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ChangeNotifierProvider(
        create: (context) => BirdPosition(),
        child: Play(),
      ),
    );
  }
}
