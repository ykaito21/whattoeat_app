import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../core/providers/slot_screen_provider.dart';
import '../../core/services/database_service.dart';
import '../global/extensions.dart';

class SlotList extends StatelessWidget {
  final List<MealWithTags> mealWithTagsList;
  const SlotList({
    Key key,
    @required this.mealWithTagsList,
  })  : assert(mealWithTagsList != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final slotScreenProvider = context.provider<SlotScreenProvider>();
    return ListWheelScrollView.useDelegate(
      controller: slotScreenProvider.slotScrollController,
      physics: FixedExtentScrollPhysics(),
      itemExtent: 100.0,
      childDelegate: ListWheelChildLoopingListDelegate(
        children: mealWithTagsList.isEmpty
            ? _emptyList(context)
            : _mealList(context, mealWithTagsList),
      ),
    );
  }

  List<Widget> _emptyList(BuildContext context) {
    return <Widget>[
      Container(
        child: Center(
          child: AutoSizeText(
            context.translate('slotEmpty'),
            style: context.baseTextStyleWithAccent,
            textAlign: TextAlign.center,
            minFontSize: 24,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ];
  }

  List<Widget> _mealList(
      BuildContext context, List<MealWithTags> mealWithTagsList) {
    return <Widget>[
      ...mealWithTagsList.map(
        (MealWithTags mealWithTags) {
          return Container(
            child: Center(
              child: AutoSizeText(
                mealWithTags.meal.name,
                style: context.baseTextStyleWithAccent,
                textAlign: TextAlign.center,
                minFontSize: 24,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      )
    ];
  }
}
