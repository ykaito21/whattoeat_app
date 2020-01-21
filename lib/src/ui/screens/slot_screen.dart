import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../widgets/tag_list.dart';
import '../shared/widgets/base_button.dart';
import '../global/style_list.dart';
import 'write_meal_screen.dart';

class SlotScreen extends StatefulWidget {
  const SlotScreen({Key key}) : super(key: key);

  @override
  _SlotScreenState createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  FixedExtentScrollController _slotScrollController =
      FixedExtentScrollController();
  int index = 0;
  bool isScrolling = false;
  Random random = Random();

  List<String> nameList = [
    "パイ包み焼きサラダを添えて",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  void dispose() {
    _slotScrollController.dispose();
    super.dispose();
  }

  void slotStart() {
    _slotScrollController.animateToItem(
      _slotScrollController.selectedItem +
          ((nameList.length * 3) + random.nextInt(nameList.length)),
      duration: Duration(seconds: 3),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'What',
              style: StyleList.appBarTitleStyle,
            ),
            ClipRect(
              child: Container(
                child: Align(
                  alignment: Alignment.center,
                  heightFactor: 0.6,
                  child: Text(
                    '2\n2',
                    style: StyleList.appBarTitleStyle.copyWith(
                      height: 0.9,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              'Eat',
              style: StyleList.appBarTitleStyle,
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: StyleList.horizontalPadding20,
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 200.0,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          child: Text(
                            'You\'re',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 48.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Text(
                            'going to',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 48.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          child: Text(
                            'eat',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 48.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100.0,
                  child: ListWheelScrollView.useDelegate(
                    controller: _slotScrollController,
                    physics: FixedExtentScrollPhysics(),
                    itemExtent: 100.0,
                    childDelegate: ListWheelChildLoopingListDelegate(
                      children: <Widget>[
                        ...nameList.map(
                          (String name) {
                            return Container(
                              child: Center(
                                child: AutoSizeText(
                                  name,
                                  style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 48.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  textAlign: TextAlign.center,
                                  minFontSize: 24,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            StyleList.verticalBox20,
            Expanded(
              child: Container(
                // constraints: BoxConstraints(
                //     maxHeight: 200.0,
                //     ),
                //* if using floating action button need maring
                // padding: StyleList.bottomPadding50,
                child: SingleChildScrollView(
                  child: TagList(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: BaseButton(
                  onPressed: () {
                    slotStart();
                  },
                  text: 'Spin',
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: Container(
      //   width: deviceWidth,
      //   padding: StyleList.horizontalPadding10,
      //   child: BaseButton(
      //     onPressed: () {
      //       slotStart();
      //     },
      //     text: 'Spin',
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
