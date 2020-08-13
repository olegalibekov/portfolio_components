import 'package:flutter/material.dart';

class LightObject extends StatefulWidget {
  final opacity;

  const LightObject({Key key, @required this.opacity}) : super(key: key);

  @override
  _LightObjectState createState() => _LightObjectState();
}

class _LightObjectState extends State<LightObject> {
  double _objectWidth = 8;
  double _objectHeight = 200;
  double _edgesHeight = 6;
  double _objectRadius = 1.5;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: _objectWidth,
        height: _objectHeight,
        child: Stack(children: [
          Align(
              alignment: Alignment.center,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(widget.opacity),
                      borderRadius: BorderRadius.circular(_objectRadius)),
                  width: _objectWidth,
                  height: _objectHeight - _edgesHeight * 2)),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(69, 69, 69, 1)
                          .withOpacity(widget.opacity),
                      borderRadius: BorderRadius.circular(_objectRadius)),
                  width: _objectWidth,
                  height: _edgesHeight)),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(69, 69, 69, 1)
                          .withOpacity(widget.opacity),
                      borderRadius: BorderRadius.circular(_objectRadius)),
                  width: _objectWidth,
                  height: _edgesHeight))
        ]));
  }
}
