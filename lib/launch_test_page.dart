import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'widgets/story_widget.dart';

class LaunchTestPage extends StatefulWidget {
  @override
  _LaunchTestPageState createState() => _LaunchTestPageState();
}

class _LaunchTestPageState extends State<LaunchTestPage> {
  VideoPlayerController _videoController;

  List<StoryWidgetComponent> _storyComponents;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/video/nebula.mp4');
    _videoController.initialize().then((_) => setState(() {}));
    _storyComponents = [
      StoryWidgetComponent(
          4000, Image.asset('assets/images/1.jpg', fit: BoxFit.cover)),
      StoryWidgetComponent(
          6000, Image.asset('assets/images/4.jpg', fit: BoxFit.cover)),
      StoryWidgetComponent(
          15000,
          RotatedBox(quarterTurns: 1, child: VideoPlayer(_videoController)),
          _videoController),
      StoryWidgetComponent(
          5000, Image.asset('assets/images/2.jpg', fit: BoxFit.cover)),
    ];
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFF262626),
        body: StoryWidget(storyComponents: _storyComponents));
  }
}
