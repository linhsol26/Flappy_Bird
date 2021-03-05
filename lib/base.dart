import 'package:flutter/material.dart';

class Base extends StatelessWidget {
  final double value;

  const Base({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-(12 * 4) * value, 0),
      child: FittedBox(
        child: SizedBox(
          height: 112,
          width: MediaQuery.of(context).size.width * 2,
          child: Image.asset("assets/sprites/base.png",
              repeat: ImageRepeat.repeatX,
              alignment: Alignment.centerLeft,
              fit: BoxFit.contain),
        ),
      ),
    );
  }
}
