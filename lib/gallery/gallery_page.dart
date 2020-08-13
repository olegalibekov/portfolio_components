import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:portfolio_components/gallery/app_sample.dart';
import 'package:portfolio_components/light_animation/light_object.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
//          Positioned(
//              left: 880,
//              top: 210,
//              child: Transform(
//                  transform: Matrix4.rotationZ(pi / 2)..scale(1.2),
//                  child: LightObject(opacity: 1))),
          Positioned(left: 590, top: 100, child: lightGradient),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: 180),
              Stack(
                  alignment: Alignment.topCenter,
                  children: [appFrames, appSample]),
              SizedBox(height: 36),
//              appOpen
            ]),
            SizedBox(width: 36),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [appName, SizedBox(height: 24), description, appOpen])
          ])
        ]));
  }

  Widget topLamp = Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)));

  Widget appRope({@required double angle}) {
    return Transform(
        transform: Matrix4.rotationZ(angle),
        child: Container(width: 2, height: 140, color: Colors.white));
  }

  Widget appSample = Container(
      width: 310,
      height: 576,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            CounterApp(),
            Container(color: Colors.transparent.withOpacity(0.0))
          ])));

  Widget appFrames = Container(
      decoration: BoxDecoration(color: Colors.black, boxShadow: [
        BoxShadow(
            color: Colors.black,
            spreadRadius: 16,
            blurRadius: 18,
            offset: Offset(0, 3))
      ]),
      width: 324,
      height: 590);

  Widget lightGradient = ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 0),
      child: Container(
          width: 350,
          height: 850,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.white.withOpacity(0),
                Colors.white.withOpacity(1)
              ]))));

//  Widget appName = Container(
//      decoration: BoxDecoration(
//          boxShadow: [
//            BoxShadow(
//                color: Colors.black,
//                spreadRadius: 12,
//                blurRadius: 12,
//                offset: Offset(0, 3))
//          ],
//          color: Colors.white,
//          borderRadius: BorderRadius.circular(4),
////          border: Border.all(width: 3, color: Colors.blue)
//      ),
//      child: Padding(
//          padding: const EdgeInsets.all(6),
//          child: Text('Counter app',
//              style: TextStyle(fontSize: 26, color: Colors.blue))));

  Widget appName =
      Text('Counter app', style: TextStyle(fontSize: 36, color: Colors.white));

  Widget appOpen = RaisedButton(
      onPressed: () {},
//      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text('Open',
              style: TextStyle(fontSize: 24, color: Colors.white))));

  Widget description = Text(
      'Tap screen to start count app.\n'
      'Can count by clicking microphone.\n'
      'Previous counting will be saved.\n'
      'Tap reset icon to reset the counting.\n'
      'Tap add button to add a new counter.\n'
      'Use counter list to manage counters.\n',
      style: TextStyle(fontSize: 22, color: Colors.white));
}

//          Positioned(
//              left: 830,
//              top: 90,
//              child: Column(children: [
//                topLamp,
//                Row(
//                    mainAxisSize: MainAxisSize.min,
//                    children: [appRope(angle: pi / 3), appRope(angle: -pi / 3)])
//              ])),
