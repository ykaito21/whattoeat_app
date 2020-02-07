import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/slot_screen_provider.dart';
import '../../core/services/database_service.dart';

class SlotList extends StatelessWidget {
  final List<MealWithTags> mealWithTagsList;
  const SlotList({
    Key key,
    @required this.mealWithTagsList,
  })  : assert(mealWithTagsList != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final SlotScreenProvider slotScreenProvider =
        Provider.of<SlotScreenProvider>(context, listen: false);
    //todo improve layout
    return ListWheelScrollView.useDelegate(
      controller: slotScreenProvider.slotScrollController,
      physics: FixedExtentScrollPhysics(),
      itemExtent: 100.0,
      childDelegate: ListWheelChildLoopingListDelegate(
        children: mealWithTagsList.length == 0
            ? <Widget>[
                Container(
                  child: Center(
                    child: AutoSizeText(
                      'NO OPTION',
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
                ),
              ]
            : <Widget>[
                //todo
                ...mealWithTagsList.map(
                  (MealWithTags mealWithTags) {
                    //todo
                    if (mealWithTags == null) return Container();
                    return Container(
                      child: Center(
                        child: AutoSizeText(
                          mealWithTags.meal.name,
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
    );
  }
}
