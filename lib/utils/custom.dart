import 'package:flappy_bird/utils/bird_position.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimatedPositionedCustom extends ImplicitlyAnimatedWidget {
  const AnimatedPositionedCustom({
    Key key,
    @required this.child,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    Curve curve = Curves.linear,
    @required Duration duration,
    VoidCallback onEnd,
  })  : assert(left == null || right == null || width == null),
        assert(top == null || bottom == null || height == null),
        super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  AnimatedPositionedCustom.fromRect({
    Key key,
    this.child,
    Rect rect,
    Curve curve = Curves.linear,
    @required Duration duration,
    VoidCallback onEnd,
  })  : left = rect.left,
        top = rect.top,
        width = rect.width,
        height = rect.height,
        right = null,
        bottom = null,
        super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  final Widget child;
  final double left;
  final double top;
  final double right;
  final double bottom;
  final double width;
  final double height;

  @override
  _AnimatedPositionedCustomState createState() =>
      _AnimatedPositionedCustomState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('left', left, defaultValue: null));
    properties.add(DoubleProperty('top', top, defaultValue: null));
    properties.add(DoubleProperty('right', right, defaultValue: null));
    properties.add(DoubleProperty('bottom', bottom, defaultValue: null));
    properties.add(DoubleProperty('width', width, defaultValue: null));
    properties.add(DoubleProperty('height', height, defaultValue: null));
  }
}

class _AnimatedPositionedCustomState
    extends AnimatedWidgetBaseState<AnimatedPositionedCustom> {
  Tween<double> _left;
  Tween<double> _top;
  Tween<double> _right;
  Tween<double> _bottom;
  Tween<double> _width;
  Tween<double> _height;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _left = visitor(_left, widget.left,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>;
    _top = visitor(_top, widget.top,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>;
    _right = visitor(_right, widget.right,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>;
    _bottom = visitor(_bottom, widget.bottom,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>;
    _width = visitor(_width, widget.width,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>;
    _height = visitor(_height, widget.height,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>;
  }

  @override
  Widget build(BuildContext context) {
    BirdPosition _birdPos = Provider.of<BirdPosition>(context);
    _birdPos.changePositionNotListener(_top?.evaluate(animation));

    return Positioned(
      child: widget.child,
      left: _left?.evaluate(animation),
      top: _top?.evaluate(animation),
      right: _right?.evaluate(animation),
      bottom: _bottom?.evaluate(animation),
      width: _width?.evaluate(animation),
      height: _height?.evaluate(animation),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description.add(ObjectFlagProperty<Tween<double>>.has('left', _left));
    description.add(ObjectFlagProperty<Tween<double>>.has('top', _top));
    description.add(ObjectFlagProperty<Tween<double>>.has('right', _right));
    description.add(ObjectFlagProperty<Tween<double>>.has('bottom', _bottom));
    description.add(ObjectFlagProperty<Tween<double>>.has('width', _width));
    description.add(ObjectFlagProperty<Tween<double>>.has('height', _height));
  }
}
