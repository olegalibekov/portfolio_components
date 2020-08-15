import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:video_player/video_player.dart';

class StoryWidgetComponent {
  final int durationMilS;
  final Widget storyWidget;
  final VideoPlayerController videoPlayerController;

  StoryWidgetComponent(this.durationMilS, this.storyWidget,
      [this.videoPlayerController]);
}

class StoryWidget extends StatefulWidget {
  final List<StoryWidgetComponent> storyComponents;

  const StoryWidget({Key key, @required this.storyComponents})
      : super(key: key);

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget>
    with TickerProviderStateMixin {
  ValueNotifier<int> _currentPage = ValueNotifier<int>(0);
  List<double> _storyComponentsIndicatorValues = [];
  AnimationController _timerController;
  PageController _pageController;
  Size _widgetSize = Size(450, 800);

  CountdownTimer _countdownTimer;
  Animation _timerAnimationTween;

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    widget.storyComponents
        .forEach((element) => _storyComponentsIndicatorValues.add(0));
    _pageController = PageController(initialPage: _currentPage.value);
    _currentPage.addListener(() {
      for (int i = 0; i < _currentPage.value; i++)
        setState(() => _storyComponentsIndicatorValues[i] = 1);
      for (int i = _storyComponentsIndicatorValues.length - 1;
          i > _currentPage.value - 1;
          i--) setState(() => _storyComponentsIndicatorValues[i] = 0);
      _pageController.animateToPage(_currentPage.value,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      if (widget.storyComponents[_currentPage.value].videoPlayerController !=
          null) {
        widget.storyComponents[_currentPage.value].videoPlayerController
            .seekTo(Duration(seconds: 0));
        widget.storyComponents[_currentPage.value].videoPlayerController.play();
      }
      startTimer();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: _widgetSize.width, maxHeight: _widgetSize.height),
          child: GestureDetector(
              onTapDown: (details) {
                double x = details.localPosition.dx;
                if (x < _widgetSize.width / 2 && _currentPage.value != 0) {
                  _currentPage.value -= 1;
                } else if (x > _widgetSize.width / 2 &&
                    _currentPage.value != widget.storyComponents.length - 1) {
                  _currentPage.value += 1;
                }
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(children: [
                    pageViewSection(),
                    storyIndicatorSection()
                  ])))),
      SizedBox(height: 36)
    ]));
  }

  startTimer() {
    _timerController = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds:
                widget.storyComponents[_currentPage.value].durationMilS));
    _timerController.addListener(() {
      _storyComponentsIndicatorValues[_currentPage.value] =
          _timerController.value;
      if (_timerController.isCompleted &&
          _currentPage.value != widget.storyComponents.length - 1) {
        _currentPage.value += 1;
      }
    });
    _timerController.forward();
  }

//    _countdownTimer =
//        CountdownTimer(Duration(milliseconds: 3000), Duration(milliseconds: 5));
//    _countdownTimer.listen((data) {
//      int milliSeconds = data.elapsed.inMilliseconds;
//      setState(() {
//        _storyComponentsIndicatorValues[_currentPage.value] =
//            milliSeconds / 3000;
//      });
//    });
//    ..onDone(() {
//    if (_currentPage.value != widget.storyComponents.length - 1) {
//    _currentPage.value += 1;
//    }
//    });
//  }

  Widget pageViewSection() {
    return PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: [
          for (dynamic storyComponent in widget.storyComponents)
            storyComponent.storyWidget
        ]);
  }

  Widget storyIndicatorSection() {
    return Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 6.0, right: 6.0),
        child: Row(children: [
          for (int storyComponentIndex = 0;
              storyComponentIndex < widget.storyComponents.length;
              storyComponentIndex++)
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
//              child: LinearProgress(
//                  progressValue:
//                      _storyComponentsIndicatorValues[storyComponentIndex]),
                    child: AnimatedBuilder(
                        animation: _timerController,
                        builder: (BuildContext context, Widget child) {
                          return LinearProgress(
                              progressValue: _storyComponentsIndicatorValues[
                                  storyComponentIndex]);
                        })))
        ]));
  }
}

class LinearProgress extends StatefulWidget {
  final progressValue;

  const LinearProgress({Key key, @required this.progressValue})
      : super(key: key);

  @override
  _LinearProgressState createState() => _LinearProgressState();
}

class _LinearProgressState extends State<LinearProgress> {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.white),
        backgroundColor: Colors.white.withOpacity(0.6),
        value: widget.progressValue,
        minHeight: 2);
  }
}
