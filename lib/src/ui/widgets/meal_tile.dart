import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
import '../../core/providers/app_provider.dart';
import '../../core/services/database_service.dart';
import '../global/routes/route_path.dart';
import '../global/style_list.dart';
import '../global/extensions.dart';

import '../shared/platform/platform_alert_dialog.dart';

class MealTile extends StatelessWidget {
  final MealWithTags mealWithTags;

  const MealTile({
    Key key,
    @required this.mealWithTags,
  })  : assert(mealWithTags != null),
        super(key: key);

  String get mealName => mealWithTags.meal.name;
  List<Tag> get tags => mealWithTags.tags;

  Future<bool> _onWillDismiss(context) {
    return PlatformAlertDialog(
      title: context.localizeAlertTtile(mealName, 'alertDeleteTitle'),
      content: context.translate('alertDeleteContentMeal'),
      defaultActionText: context.translate('delete'),
      cancelActionText: context.translate('cancel'),
    ).show(context);
  }

  void _onDismissed(BuildContext context, AppProvider appProvider) async {
    await appProvider.deleteMealWithTags(mealWithTags);
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        context.baseSnackBar(context.localizeMessage(mealName, 'wasDeleted')),
      );
  }

  Future<void> _onTapDelete(
      BuildContext context, AppProvider appProvider) async {
    context.unfocus;
    final confirmation = await _onWillDismiss(context);
    if (confirmation) {
      _onDismissed(context, appProvider);
    }
  }

  void _onTapEdit(BuildContext context) {
    context.unfocus;
    context.pushNamed(RoutePath.writeMealScreen,
        arguments: mealWithTags, rootNavigator: true);
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.provider<AppProvider>();
    return Slidable(
      //* to work with SlidableDismissal and CupertinoTabView
      key: ValueKey(mealWithTags.meal),
      dismissal: SlidableDismissal(
        onWillDismiss: (actionType) => _onWillDismiss(context),
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) => _onDismissed(context, appProvider),
      ),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ListTile(
        onTap: () => _onTapEdit(context),
        contentPadding: StyleList.horizontalPadding20,
        title: Text(
          mealName,
          style: StyleList.baseTitleTextStyle,
        ),
        subtitle: Wrap(children: _tags(context, tags)),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          onTap: () => _onTapEdit(context),
          color: context.accentColor,
          foregroundColor: context.appliedSlidableColor,
          icon: Icons.edit,
          caption: context.translate('edit'),
        ),
        IconSlideAction(
          onTap: () async => await _onTapDelete(context, appProvider),
          color: context.accentColor,
          foregroundColor: context.appliedSlidableColor,
          icon: Icons.delete,
          caption: context.translate('delete'),
        ),
      ],
    );
  }

  List<Widget> _tags(BuildContext context, List<Tag> tags) {
    return <Widget>[
      ...tags.map(
        (tag) => Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            decoration: BoxDecoration(
              color: context.accentColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              tag.name,
              style: TextStyle(
                color: context.appliedSlidableColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      )
    ];
  }
}
