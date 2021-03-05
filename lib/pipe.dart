import 'dart:math';

import 'package:flutter/material.dart';

class Pipe extends StatefulWidget {
  @override
  _PipeState createState() => _PipeState();
}

class _PipeState extends State<Pipe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 840,
      width: 52,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Transform.rotate(
              angle: pi,
              child: Image.asset(
                "assets/sprites/pipe-green.png",
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(height: 100),
            Image.asset(
              "assets/sprites/pipe-green.png",
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
    );
  }
}
