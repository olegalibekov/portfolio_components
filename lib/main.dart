import 'package:flutter/material.dart';
import 'package:portfolio_components/gallery/app_sample.dart';
import 'package:portfolio_components/gallery/gallery_page.dart';

import 'gallery/rotated_sample_app.dart';

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
        home:GalleryPage());
  }
}
