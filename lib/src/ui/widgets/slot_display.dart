import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/slot_screen_provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/services/database_service.dart';
import '../shared/widgets/stream_wrapper.dart';
import '../widgets/slot_list.dart';

class SlotDisplay extends StatelessWidget {
  const SlotDisplay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    final SlotScreenProvider slotScreenProvider =
        Provider.of<SlotScreenProvider>(context, listen: false);
    return Column(
      children: <Widget>[
        Container(
          height: 200.0,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  //todo i18n
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
