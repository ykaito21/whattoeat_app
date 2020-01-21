import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import '../../ui/global/color_list.dart';

class TagList extends StatelessWidget {
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

  final bool needTextField;

  @override
  Widget build(BuildContext context) {
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
        return ItemTags(
          onPressed: (item) => print(item),
          key: UniqueKey(),
          index: index,
          title: item,
          active: false,
          customData: item,
          elevation: 0,
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).primaryColor == ColorList.primaryCream
              ? Colors.grey[300]
              : Colors.grey[600],
          activeColor: Theme.of(context).accentColor,
          textColor: Theme.of(context).primaryColor == ColorList.primaryCream
              ? Colors.black
              : Colors.white,
          textActiveColor:
              Theme.of(context).primaryColor == ColorList.primaryCream
                  ? Colors.white
                  : Colors.black,
          border: Border.all(style: BorderStyle.none),
          textStyle: TextStyle(
            fontSize: 16,
          ),
        );
      },
    );
  }
}
