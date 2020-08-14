import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:portfolio_components/gallery/app_sample.dart';

class RotatedSampleApp extends StatefulWidget {
  @override
  _RotatedSampleAppState createState() => _RotatedSampleAppState();
}

ValueNotifier xTranslate = ValueNotifier<double>(0);
ValueNotifier yTranslate = ValueNotifier<double>(0);

class _RotatedSampleAppState extends State<RotatedSampleApp> {
  bool defaultPosition = true;
  double localX = 0;
  double localY = 0;
  double appWidth = 310;
  double appHeight = 576;

  @override
  Widget build(BuildContext context) {
    double percentageX = (localX / appWidth) * 100;
    double percentageY = (localY / appHeight) * 100;
    return Container(
//      width: appWidth + 100.0,
//      height: appHeight + 100.0,
//        decoration: BoxDecoration(
//            border: Border.all(color: Colors.black, width: 5.5),
//            borderRadius: BorderRadius.circular(20)),
      child: Transform(
          transform: Matrix4.identity()
//          ..setEntry(3, 2, 0.001)
            ..rotateX(defaultPosition ? 0 : (0.15 * (percentageY / 50)  -0.15))
            ..rotateY(
                defaultPosition ? 0 : (-0.15 * (percentageX / 50) + 0.15)),
//            ..rotateX(defaultPosition ? 0 : 0)
//            ..rotateY(defaultPosition ? 0 : 0),
          alignment: FractionalOffset.center,
          child: GestureDetector(
              onPanCancel: () => setState(() => defaultPosition = true),
              onPanDown: (_) => setState(() => defaultPosition = false),
              onPanEnd: (_) => setState(() {
                    localY = appHeight / 2;
                    localX = appWidth / 2;
                    defaultPosition = true;
                  }),
              onPanUpdate: (details) {
                if (mounted) setState(() => defaultPosition = false);
                if (details.localPosition.dx > 0 &&
                    details.localPosition.dy < appHeight) {
                  if (details.localPosition.dx < appWidth &&
                      details.localPosition.dy > 0) {
                    localX = details.localPosition.dx;
                    localY = details.localPosition.dy;
                  }
                }
                xTranslate.value = (2 * (percentageX / 50)  -2);
                yTranslate.value = (2 * (percentageY / 50)  -2);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Transform(
                    transform: Matrix4.identity()
                      ..translate(
                          defaultPosition ? 0.0 : (2 * (percentageX / 50)  -2),
                          defaultPosition ? 0.0 : (2 * (percentageY / 50)  -2),
//                          defaultPosition ? 0.0 : (8 * (percentageX / 50) + -8),
//                          defaultPosition ? 0.0 : (8 * (percentageY / 50) + -8),
                          0.0),
//                      ..translate(0, 0, 0.0),
                    alignment: FractionalOffset.center,
                    child: AppSample()),
              ))),
    );
  }
}
