import 'package:flutter/material.dart';
import 'menu/menu_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (scroll) {
              scroll.disallowGlow();
              return false;
            },
            child: MenuPage()));
  }
}

// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
//
//import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart';
//
//import 'container_transition.dart';
//
//
//void main() {
//  runApp(
//    MaterialApp(
//      theme: ThemeData.from(
//        colorScheme: const ColorScheme.light(),
//      ).copyWith(
//        pageTransitionsTheme: const PageTransitionsTheme(
//          builders: <TargetPlatform, PageTransitionsBuilder>{
//            TargetPlatform.android: ZoomPageTransitionsBuilder(),
//          },
//        ),
//      ),
//      home: _TransitionsHomePage(),
//    ),
//  );
//}
//
//class _TransitionsHomePage extends StatefulWidget {
//  @override
//  _TransitionsHomePageState createState() => _TransitionsHomePageState();
//}
//
//class _TransitionsHomePageState extends State<_TransitionsHomePage> {
//  bool _slowAnimations = false;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: const Text('Material Transitions')),
//      body: Column(
//        children: <Widget>[
//          Expanded(
//            child: ListView(
//              children: <Widget>[
//                _TransitionListTile(
//                  title: 'Container transform',
//                  subtitle: 'OpenContainer',
//                  onTap: () {
//                    Navigator.of(context).push(
//                      MaterialPageRoute<void>(
//                        builder: (BuildContext context) {
//                          return OpenContainerTransformDemo();
//                        },
//                      ),
//                    );
//                  },
//                ),
////                _TransitionListTile(
////                  title: 'Shared axis',
////                  subtitle: 'SharedAxisTransition',
////                  onTap: () {
////                    Navigator.of(context).push(
////                      MaterialPageRoute<void>(
////                        builder: (BuildContext context) {
////                          return SharedAxisTransitionDemo();
////                        },
////                      ),
////                    );
////                  },
////                ),
////                _TransitionListTile(
////                  title: 'Fade through',
////                  subtitle: 'FadeThroughTransition',
////                  onTap: () {
////                    Navigator.of(context).push(
////                      MaterialPageRoute<void>(
////                        builder: (BuildContext context) {
////                          return FadeThroughTransitionDemo();
////                        },
////                      ),
////                    );
////                  },
////                ),
////                _TransitionListTile(
////                  title: 'Fade',
////                  subtitle: 'FadeScaleTransition',
////                  onTap: () {
////                    Navigator.of(context).push(
////                      MaterialPageRoute<void>(
////                        builder: (BuildContext context) {
////                          return FadeScaleTransitionDemo();
////                        },
////                      ),
////                    );
////                  },
////                ),
//              ],
//            ),
//          ),
//          const Divider(height: 0.0),
//          SafeArea(
//            child: SwitchListTile(
//              value: _slowAnimations,
//              onChanged: (bool value) async {
//                setState(() {
//                  _slowAnimations = value;
//                });
//                // Wait until the Switch is done animating before actually slowing
//                // down time.
//                if (_slowAnimations) {
//                  await Future<void>.delayed(const Duration(milliseconds: 300));
//                }
//                timeDilation = _slowAnimations ? 20.0 : 1.0;
//              },
//              title: const Text('Slow animations'),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//class _TransitionListTile extends StatelessWidget {
//  const _TransitionListTile({
//    this.onTap,
//    this.title,
//    this.subtitle,
//  });
//
//  final GestureTapCallback onTap;
//  final String title;
//  final String subtitle;
//
//  @override
//  Widget build(BuildContext context) {
//    return ListTile(
//      contentPadding: const EdgeInsets.symmetric(
//        horizontal: 15.0,
//      ),
//      leading: Container(
//        width: 40.0,
//        height: 40.0,
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(20.0),
//          border: Border.all(
//            color: Colors.black54,
//          ),
//        ),
//        child: const Icon(
//          Icons.play_arrow,
//          size: 35,
//        ),
//      ),
//      onTap: onTap,
//      title: Text(title),
//      subtitle: Text(subtitle),
//    );
//  }
//}
