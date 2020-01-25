import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import '../../ui/global/color_list.dart';

class TagList extends StatelessWidget {
  final bool needTextField;

  TagList({
    Key key,
    this.needTextField: false,
  }) : super(key: key);

  static const List<String> nameList = [
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
    "Dec",
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
    "Dec",
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
    "Dec",
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

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  _getAllItem() {
    List<Item> lst = _tagStateKey.currentState?.getAllItem;
    if (lst != null)
      lst.where((a) => a.active == true).forEach((a) => print(a.title));
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).primaryColor == ColorList.primaryCream;
    return Tags(
      key: _tagStateKey,
      itemCount: nameList.length,
      textField: needTextField
          ? TagsTextField(
              textStyle: TextStyle(fontSize: 20.0),
              onSubmitted: (String str) {
                // Add item to the data source.
                // setState(() {
                //   // required
                //   _items.add(str);
                // });
              },
            )
          : null,
      itemBuilder: (int index) {
        final item = nameList[index];
        //TODO CHECK ELEVATION AND PADDING and border
        return ItemTags(
          // pressEnabled: false,
          onPressed: (item) {
            _getAllItem();
          },
          key: UniqueKey(),
          index: index,
          title: item,
          active: false,
          customData: item,
          elevation: 0,
          border: Border.all(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(30),
          // border: Border.all(color: Theme.of(context).accentColor),
          color: isDarkMode ? Colors.grey[200] : Colors.grey[700],
          activeColor: Theme.of(context).accentColor,
          textColor: isDarkMode ? Colors.black : Colors.white,
          textActiveColor: isDarkMode ? Colors.white : Colors.black,
          textStyle: TextStyle(
            fontSize: 16,
          ),
        );
      },
    );
  }
}
