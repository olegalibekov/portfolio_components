import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'light_object.dart';

class LightPage extends StatefulWidget {
  @override
  _LightPageState createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> with TickerProviderStateMixin {
  AnimationController _firstLightController;
  Animation _xFirstLightAnimationTween;
  Animation _yFirstLightAnimationTween;
  Animation _opacityFirstLightAnimationTween;

//  Animation _widthInPercentsFirstLightAnimationTween;

  AnimationController _secondLightController;
  Animation _xSecondLightAnimationTween;
  Animation _ySecondLightAnimationTween;
  Animation _opacitySecondLightAnimationTween;

//  Animation _widthInPercentsSecondLightAnimationTween;

  AnimationController _thirdLightController;
  Animation _xThirdLightAnimationTween;
  Animation _yThirdLightAnimationTween;
  Animation _opacityThirdLightAnimationTween;

//  Animation _widthInPercentsThirdLightAnimationTween;

  AnimationController _triangleController;
  Animation _triangleAnimationTween;
  Size _screenSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstLightController.dispose();
    _secondLightController.dispose();
    _thirdLightController.dispose();
    _triangleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
//    print(_screenSize);
    Tween _firstXLightRange =
        Tween(begin: _screenSize.height / 3, end: _screenSize.width / 2 - 12);
    Tween _firstYLightRange = Tween(
        begin: _screenSize.height - _screenSize.height * 0.3,
        end: _screenSize.height / 2 - 70);
    Tween _opacityFirstLightRange = Tween(begin: 0.0, end: 1.0);
//    Tween _widthInPercentsFirstLightRange = Tween(begin: 0.0, end: 1.0);

    _firstLightController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    Animation _firstCurve = CurvedAnimation(
        parent: _firstLightController, curve: Curves.easeOutExpo);
    _xFirstLightAnimationTween = _firstXLightRange.animate(_firstCurve);
    _yFirstLightAnimationTween = _firstYLightRange.animate(_firstCurve);
    _opacityFirstLightAnimationTween =
        _opacityFirstLightRange.animate(_firstLightController);
//    _widthInPercentsFirstLightAnimationTween =
//        _widthInPercentsFirstLightRange.animate(_firstLightController);
    _firstLightController.forward();

    Tween _secondXLightRange = Tween(
        begin: _screenSize.width - _screenSize.width * 0.5,
        end: _screenSize.width / 2);
    Tween _secondYLightRange = Tween(
        begin: _screenSize.height * 0.3, end: _screenSize.height / 2 - 65);
    Tween _opacitySecondLightRange = Tween(begin: 0.0, end: 1);
    Tween _widthInPercentsSecondLightRange = Tween(begin: 0.0, end: 1.0);

    _secondLightController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    Animation _secondCurve = CurvedAnimation(
        parent: _secondLightController, curve: Curves.easeOutExpo);
    _xSecondLightAnimationTween = _secondXLightRange.animate(_secondCurve);
    _ySecondLightAnimationTween = _secondYLightRange.animate(_secondCurve);
    _opacitySecondLightAnimationTween =
        _opacitySecondLightRange.animate(_secondLightController);
//    _widthInPercentsSecondLightAnimationTween =
//        _widthInPercentsSecondLightRange.animate(_secondLightController);

    Tween _thirdXLightRange = Tween(
        begin: _screenSize.width - _screenSize.width * 0.3,
        end: _screenSize.width / 2 + 100);
    Tween _thirdYLightRange = Tween(
        begin: _screenSize.height * 0.7, end: _screenSize.height / 2 + 112);
    Tween _opacityThirdLightRange = Tween(begin: 0.0, end: 1.0);
    Tween _widthInPercentsThirdLightRange = Tween(begin: 0.0, end: 1.0);

    _thirdLightController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    Animation _thirdCurve = CurvedAnimation(
        parent: _thirdLightController, curve: Curves.easeOutExpo);
    _xThirdLightAnimationTween = _thirdXLightRange.animate(_thirdCurve);
    _yThirdLightAnimationTween = _thirdYLightRange.animate(_thirdCurve);
    _opacityThirdLightAnimationTween =
        _opacityThirdLightRange.animate(_thirdLightController);
//    _widthInPercentsThirdLightAnimationTween =
//        _widthInPercentsThirdLightRange.animate(_thirdLightController);

    _firstLightController.addStatusListener((status) {
      if (status == AnimationStatus.completed) _secondLightController.forward();
    });

    _secondLightController.addStatusListener((status) {
      if (status == AnimationStatus.completed) _thirdLightController.forward();
    });

    AnimationController _decreasingController =
        AnimationController(vsync: this, duration: Duration(seconds: 7));
    Tween _scaleRange = Tween(begin: 2.0, end: 0.0);
    Tween _accelerationRange = Tween(begin: 1.0, end: 10.0);
    Animation _decreasingCurve = CurvedAnimation(
        parent: _decreasingController, curve: Curves.easeInOutQuint);
    Animation _scaleAnimationTween = _scaleRange.animate(_decreasingCurve);
    Animation _accelerationAnimationTween =
        _accelerationRange.animate(_decreasingCurve);

    _triangleController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 16000));
    Tween _triangleRotationTween = Tween(begin: 0.0, end: 2 * pi);
    _triangleAnimationTween =
        _triangleRotationTween.animate(_triangleController);
    _triangleController.repeat();

    Timer(Duration(seconds: 9), () {
      _decreasingController.forward();
    });

    return Scaffold(
        backgroundColor: Colors.black,
        body: AnimatedBuilder(
            animation: _triangleController,
            builder: (BuildContext context, Widget child) => Transform(
                origin:
                    Offset(_screenSize.width / 2, _screenSize.height / 2 + 55),
                transform: Matrix4.rotationZ(
                    _triangleAnimationTween.value.toDouble() *
                        _accelerationAnimationTween.value)
                  ..scale(_scaleAnimationTween.value.toDouble()),
                child: Stack(children: [
                  AnimatedBuilder(
                      animation: _firstLightController,
                      child: LightObject(
                        opacity: _opacityFirstLightAnimationTween.value,
//                          widthInPercents:
//                              _widthInPercentsFirstLightAnimationTween.value
                      ),
                      builder: (BuildContext context, Widget child) {
                        return Positioned(
                            left: _xFirstLightAnimationTween.value,
                            top: _yFirstLightAnimationTween.value,
                            child: Transform(
                                transform: Matrix4.rotationZ(pi / 6),
                                child: child));
                      }),
                  AnimatedBuilder(
                      animation: _secondLightController,
                      child: LightObject(
                        opacity:
                            _opacitySecondLightAnimationTween.value.toDouble(),
//                          widthInPercents:
//                              _widthInPercentsSecondLightAnimationTween.value
                      ),
                      builder: (BuildContext context, Widget child) {
                        return Positioned(
                            left: _xSecondLightAnimationTween.value,
                            top: _ySecondLightAnimationTween.value,
                            child: Transform(
                                transform: Matrix4.rotationZ(-pi / 6),
                                child: child));
                      }),
                  AnimatedBuilder(
                      animation: _thirdLightController,
                      child: LightObject(
                        opacity:
                            _opacityThirdLightAnimationTween.value.toDouble(),
//                          widthInPercents:
//                              _widthInPercentsThirdLightAnimationTween.value
                      ),
                      builder: (BuildContext context, Widget child) {
                        return Positioned(
                            left: _xThirdLightAnimationTween.value,
                            top: _yThirdLightAnimationTween.value,
                            child: Transform(
                                transform: Matrix4.rotationZ(pi / 2),
                                child: child));
                      })
                ]))));
  }
}
