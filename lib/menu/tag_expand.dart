import 'package:flutter/material.dart';

Widget tagTemplate(String tagText) {
  return Material(
      color: Colors.white.withOpacity(0.3),
      child: InkWell(
          onTap: () {},
          child: Container(
              padding: const EdgeInsets.all(4),
              child: Text('@$tagText',
                  style: TextStyle(fontSize: 18, color: Colors.white)))));
}

class TagSection extends StatefulWidget {
  final List<Widget> tagList;

  const TagSection({Key key, this.tagList}) : super(key: key);

  @override
  _TagSectionState createState() => _TagSectionState();
}

class _TagSectionState extends State<TagSection> {
  final int _firstHalfSize = 3;
  List<Widget> _firstHalf = [];
  List<Widget> _secondHalf = [];
  bool _flag = true;
  bool _isBigScreen = false;

  @override
  void initState() {
    if (widget.tagList.length > _firstHalfSize) {
      for (int tagIndex = 0; tagIndex < _firstHalfSize; tagIndex++)
        _firstHalf.add(widget.tagList[tagIndex]);
      for (int tagIndex = _firstHalfSize;
          tagIndex < widget.tagList.length;
          tagIndex++) _secondHalf.add(widget.tagList[tagIndex]);
    } else {
      _firstHalf.addAll(widget.tagList);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) _isBigScreen = true;
    return Container(
        child: _secondHalf.isEmpty
            ? tagSection(_firstHalf)
            : _isBigScreen
                ? tagSection(_firstHalf + _secondHalf)
                : AnimatedCrossFade(
                    duration: Duration(milliseconds: 300),
                    crossFadeState: _flag
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: tagSection(_firstHalf),
                    secondChild: tagSection(_firstHalf + _secondHalf)));
  }

  Widget tagSection(List<Widget> tagList) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12)
            .copyWith(bottom: _isBigScreen ? 16 : 0),
        child: Align(
            alignment: Alignment.center,
            child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 12,
                children: _isBigScreen
                    ? [...tagList]
                    : [...tagList, expandButton()])));
  }

  Widget expandButton() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(_flag ? '...' : '-',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9), fontSize: 18))),
            onTap: () => setState(() => _flag = !_flag)));
  }
}
