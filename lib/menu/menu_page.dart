import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:portfolio_components/light_animation/light_page.dart';
import 'package:portfolio_components/menu/tag_expand.dart';
import 'package:portfolio_components/story_widget/story_widget.dart';
import 'package:video_player/video_player.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  List<StoryWidgetComponent> _storyComponents;
  VideoPlayerController _videoController;
  PageController _pageController;
  Size _widgetSize;
  double _viewportFraction = 1;
  final double _storySize = 80;
  final double _fabDimension = 56.0;

  @override
  void initState() {
    _videoController = VideoPlayerController.asset('assets/video/nebula.mp4');
    _videoController.initialize();
    _storyComponents = [
      StoryWidgetComponent(
          5000, Image.asset('assets/images/1.jpg', fit: BoxFit.cover)),
      StoryWidgetComponent(
          3000, Image.asset('assets/images/4.jpg', fit: BoxFit.cover)),
      StoryWidgetComponent(
          15000,
          RotatedBox(quarterTurns: 1, child: VideoPlayer(_videoController)),
          _videoController),
      StoryWidgetComponent(
          5000, Image.asset('assets/images/2.jpg', fit: BoxFit.cover))
    ];
    _pageController =
        PageController(initialPage: 0, viewportFraction: _viewportFraction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _widgetSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        floatingActionButton: floatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 36),
              storySection(),
              SizedBox(height: 16),
              Container(
                  color: Colors.white.withOpacity(0.1),
                  child: Column(children: [
                    SizedBox(height: 18),
                    searchingSection(),
                    SizedBox(height: 16),
                    TagSection(tagList: [
                      tagTemplate('tag'),
                      tagTemplate('longLongTag'),
                      tagTemplate('shortTag'),
                      tagTemplate('tag'),
                      tagTemplate('newTag'),
                      tagTemplate('tag'),
                      tagTemplate('shortTag'),
                      tagTemplate('longLongTag')
                    ])
                  ])),
              SizedBox(height: 16),
              SizedBox(height: 1350, width: 200, child: swipeArea())
            ]));
  }

  Widget floatingActionButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          customBorder: CircleBorder(),
          onTap: () {},
          child: OpenContainer(
              useRootNavigator: true,
              openColor: Colors.transparent,
              transitionDuration: Duration(milliseconds: 300),
              transitionType: _transitionType,
              openBuilder: (BuildContext context, VoidCallback _) =>
                  LightPage(),
              closedElevation: 6.0,
              closedShape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(_fabDimension / 2))),
              closedColor: Colors.white.withOpacity(0.3),
              closedBuilder:
                  (BuildContext context, VoidCallback openContainer) =>
                      SizedBox(
                          height: _fabDimension,
                          width: _fabDimension,
                          child: Center(
                              child: Icon(Icons.home,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary))))),
    );
  }

  Widget storySection() {
    return Container(
        color: Colors.white.withOpacity(0.1),
        width: _widgetSize.width,
        height: _storySize + 30,
        child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(0),
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(width: 16),
              storyIcon('assets/images/2.jpg', 'First story'),
              storyIcon('assets/images/1.jpg', 'Second story'),
              storyIcon('assets/images/2.jpg', 'Third story'),
              storyIcon('assets/images/4.jpg', 'Fourth story'),
              storyIcon('assets/images/2.jpg', 'Fifth story'),
              SizedBox(width: 16)
            ]));
  }

  Widget storyIcon(String assetPath, String storyTitle) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
                borderRadius: BorderRadius.circular(8),
                splashColor: Colors.transparent,
                onTap: () {},
                child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(children: [
                      OpenContainer(
                          useRootNavigator: true,
                          closedColor: Colors.transparent,
                          openColor: Colors.transparent,
                          transitionType: _transitionType,
                          closedElevation: 0.0,
                          openElevation: 0.0,
                          openShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_storySize / 2))),
                          closedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_storySize / 2))),
                          closedBuilder: (BuildContext context,
                                  VoidCallback openContainer) =>
                              Container(
                                  width: _storySize,
                                  height: _storySize,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(assetPath)))),
                          openBuilder: (BuildContext context, VoidCallback _) =>
                              StoryWidget(storyComponents: _storyComponents)),
                      SizedBox(height: 6),
                      Text(storyTitle,
                          style: TextStyle(fontSize: 12, color: Colors.white))
                    ])))));
  }

  Widget searchingSection() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: TextField(
            cursorColor: Colors.white,
            style: TextStyle(fontSize: 18, color: Colors.white),
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16).copyWith(left: 16),
                suffixIcon: InkWell(
                    child: Icon(Icons.search, size: 35, color: Colors.white),
                    onTap: () {}),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 3)))));
  }

  Widget swipeArea() {
    return PageView(
        controller: _pageController,
        onPageChanged: (page) {
//              if (_pageController.page == 0)
//                setState(() {
//                  _viewportFraction = 0.5;
//                });
//              else if (page == 1)
//                setState(() {
//                  _viewportFraction = 1;
//                });
        },
        children: [
          Column(children: [
            wideButton('First'),
            wideButton('Second'),
            wideButton('Third')
          ]),
          newsSection()
        ]);
  }

//  Row(children: [wideButton(), newsSection()]
//Widget swipeArea() {
//    return Dismissible(
//        key: ValueKey('1'),
//        background: Container(
//          color: Colors.red,
//          padding: EdgeInsets.symmetric(horizontal: 20),
//          alignment: AlignmentDirectional.centerStart,
//          child: Icon(
//            Icons.delete,
//            color: Colors.white,
//          ),
//        ),
//        secondaryBackground: Container(
//          color: Colors.amber[700],
//          padding: EdgeInsets.symmetric(horizontal: 20),
//          alignment: AlignmentDirectional.centerEnd,
//          child: Icon(
//            Icons.archive,
//            color: Colors.white,
//          ),
//        ),
//        child: wideButton());
//  }

  Widget wideButton(String buttonTitle) {
    return Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: SizedBox(
            height: 80,
            width: double.infinity,
            child: RaisedButton(
                color: Colors.indigoAccent,
                padding: const EdgeInsets.only(left: 0),
                onPressed: () {},
                child: Text(buttonTitle,
                    style: TextStyle(fontSize: 20, color: Colors.white)))));
  }

  Widget newsSection() {
    return Column(children: [
      newsCard(
          title:
              'Cloud Constellation selects LeoStella to build 10 data-storage satellites',
          imagePath: 'assets/images/5.jpg',
          description:
              'WASHINGTON — Cloud Constellation, a startup focused on secure data storage in space, has selected LeoStella to build a system of 10 satellites bound for low Earth orbit.Cloud Constellation CEO Cliff Beek said LeoStella, a joint venture of Thales Alenia Space and Spaceflight Industries, beat Northrop Grumman on price, among other factors.',
          update: 'One hour ago'),
      newsCard(
          title:
              'Hubble Space Telescope detects ‘elusive’ evidence of mysterious black holes',
          imagePath: 'assets/images/3.jpg',
          description:
              'Intermediate-mass black holes are usually harder to find according to Science Focus, but data that one is tucked away in a star cluster has been found by the Hubble Space Telescope. This could provide a valuable missing link to black hole evolution. Dacheng Lin, of the University of New Hampshire, was the lead investigator and explained: “Intermediate-mass black holes are very elusive objects, and so it is critical to carefully consider and rule out alternative explanations for each candidate.',
          update: 'Three hours ago')
    ]);
  }

  Widget newsCard(
      {String heading = 'Wednesday Morning News',
      String title = 'Title',
      String imagePath = 'assets/images/1.jpg',
      String description = 'Description',
      String update = 'Two hours ago'}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
          width: double.infinity,
          color: Colors.white.withOpacity(0.1),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: const EdgeInsets.all(16),
                child: Text(heading,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500))),
            Image.asset(imagePath,
                fit: BoxFit.cover, width: double.infinity, height: 300),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500))),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(description,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 16))),
            SizedBox(height: 16),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(update,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 14)))),
            SizedBox(height: 16)
          ])),
    );
  }
}
//    return Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 6).copyWith(bottom: 10),
//        child: MaterialButton(
//            padding: const EdgeInsets.all(0),
//            onPressed: () {
//              Navigator.of(context).push(
//                  MaterialPageRoute<void>(builder: (BuildContext context) {
////                    return OpenContainerTransformDemo();
//                  }));
//            },
//            elevation: 2.0,
//            color: Colors.transparent,
//            shape: CircleBorder(),
//            child: Container(
//                width: _storySize,
//                height: _storySize,
//                decoration: BoxDecoration(
//                    shape: BoxShape.circle,
//                    image: DecorationImage(
//                        fit: BoxFit.cover,
//                        image: AssetImage('assets/images/1.jpg'))))));
