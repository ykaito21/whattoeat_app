import 'package:flutter/material.dart';
import '../../core/providers/slot_screen_provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/services/database_service.dart';
import '../global/extensions.dart';
import '../shared/widgets/stream_wrapper.dart';
import '../widgets/slot_list.dart';

class SlotDisplay extends StatelessWidget {
  const SlotDisplay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = context.provider<AppProvider>();
    final slotScreenProvider = context.provider<SlotScreenProvider>();
    return Column(
      children: <Widget>[
        Container(
          height: 200.0,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: Text(
                    context.translate('slotTitleFirst'),
                    style: TextStyle(
                      color: context.accentColor,
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
                    context.translate('slotTitleSecond'),
                    style: TextStyle(
                      color: context.accentColor,
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
                    context.translate('slotTitleThird'),
                    style: TextStyle(
                      color: context.accentColor,
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
          child: StreamWrapper<List<MealWithTags>>(
            stream: appProvider.streamMealWithTags(
              tags: slotScreenProvider.streamSlotScreenSelectedTags,
            ),
            onWaitting: (context) => Container(),
            onSuccess: (context, List<MealWithTags> mealWithTagsList) {
              return SlotList(
                mealWithTagsList: mealWithTagsList,
              );
            },
          ),
        ),
      ],
    );
  }
}
