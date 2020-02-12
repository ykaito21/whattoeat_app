import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/services/database_service.dart';
import '../global/style_list.dart';
import '../shared/platform/platform_alert_dialog.dart';
import '../screens/write_meal_screen_wrapper.dart';

class MealTile extends StatelessWidget {
  final MealWithTags mealWithTags;

  const MealTile({
    Key key,
    @required this.mealWithTags,
  })  : assert(mealWithTags != null),
        super(key: key);

  String get mealName => mealWithTags.meal.name;
  List<Tag> get tags => mealWithTags.tags;

  Future<bool> _onWillDismiss(context, String mealName) {
    //todo i18n
    return PlatformAlertDialog(
      title: 'Do you want to delete "$mealName"?',
      content: '$mealName will be deleted from list',
      defaultActionText: 'Yes',
      cancelActionText: 'No',
    ).show(context);
  }

  void _onDismissed(BuildContext context, AppProvider appProvider) {
    //todo i18n
    appProvider.deleteMealWithTags(mealWithTags);
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        StyleList.baseSnackBar(context, '"$mealName" was successfully deleted'),
      );
  }

  Future<void> _onPressedDelete(
      BuildContext context, AppProvider appProvider) async {
    final bool res = await _onWillDismiss(context, mealName);
    if (res) {
      _onDismissed(context, appProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    final Color appliedSlidableColor =
        Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white;
    return Slidable(
      //* to work with SlidableDismissal and CupertinoTabView
      key: ValueKey(mealWithTags.meal),
      dismissal: SlidableDismissal(
        onWillDismiss: (actionType) => _onWillDismiss(context, mealName),
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) => _onDismissed(context, appProvider),
      ),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ListTile(
        onTap: () {
          FocusScope.of(context).unfocus();
          Navigator.of(
            context,
            rootNavigator: true,
          ).push(
            MaterialPageRoute(
              builder: (context) =>
                  WriteMealScreenWrapper(mealWithTags: mealWithTags),
            ),
          );
        },
        contentPadding: StyleList.horizontalPadding20,
        title: Text(
          mealName,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Wrap(children: _tags(context, tags, appliedSlidableColor)),
      ),
      secondaryActions: <Widget>[
        //todo i18n
        IconSlideAction(
          onTap: () {
            //todo need focusscope? other places too? and routes
            FocusScope.of(context).unfocus();
            Navigator.of(
              context,
              rootNavigator: true,
            ).push(
              MaterialPageRoute(
                builder: (context) =>
                    WriteMealScreenWrapper(mealWithTags: mealWithTags),
              ),
            );
          },
          color: Theme.of(context).accentColor,
          foregroundColor: appliedSlidableColor,
          icon: Icons.edit,
          caption: 'Edit',
        ),
        IconSlideAction(
          onTap: () async => await _onPressedDelete(context, appProvider),
          color: Theme.of(context).accentColor,
          foregroundColor: appliedSlidableColor,
          icon: Icons.delete,
          caption: 'Delete',
        ),
      ],
    );
  }

  List<Widget> _tags(
      BuildContext context, List<Tag> tags, Color appliedSlidableColor) {
    return <Widget>[
      ...tags.map(
        (tag) => Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Container(
            padding: StyleList.verticalHorizontalPaddding25,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              tag.name,
              style: TextStyle(
                color: appliedSlidableColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      )
    ];
  }
}
