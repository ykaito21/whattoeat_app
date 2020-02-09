import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/services/database_service.dart';
import '../screens/write_meal_screen_wrapper.dart';
import '../global/color_list.dart';
import '../global/style_list.dart';

class MealTile extends StatelessWidget {
  final MealWithTags mealWithTags;
  const MealTile({
    Key key,
    @required this.mealWithTags,
  })  : assert(mealWithTags != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    final String mealName = mealWithTags.meal.name;
    final List<Tag> tags = mealWithTags.tags;
    final Color _appliedSlidableColor =
        Theme.of(context).primaryColor == ColorList.primaryCream
            ? Colors.white
            : Colors.black;
    return Slidable(
      key: UniqueKey(),
      dismissal: SlidableDismissal(
        onWillDismiss: (actionType) {
          return showDialog<bool>(
            context: context,
            builder: (context) {
              final Color _appliedColor =
                  Theme.of(context).primaryColor == Colors.white
                      ? Colors.black
                      : Colors.white;
              return Theme(
                data: ThemeData(
                  // for only alertdialog
                  colorScheme: ColorScheme(
                    background: Colors.black,
                    brightness: Brightness.light,
                    error: Colors.black,
                    onBackground: Colors.black87,
                    onError: Colors.white,
                    onSurface: Colors.black87,
                    onSecondary: Colors.black87,
                    onPrimary: Colors.black,
                    primary: Theme.of(context)
                        .accentColor, //  need this for flat button color
                    primaryVariant: Theme.of(context).accentColor,
                    secondary: Colors.black,
                    secondaryVariant: Colors.black,
                    surface: Colors.white,
                  ),
                  accentColor: Theme.of(context).accentColor,
                  dialogBackgroundColor: Theme.of(context).primaryColor,
                  textTheme: TextTheme(
                    title: TextStyle(
                      color: _appliedColor,
                    ),
                    subhead: TextStyle(
                      color: _appliedColor,
                    ),
                  ),
                ),
                child: AlertDialog(
                  title: Text('Delete'),
                  content: Text('\"test\" will be deleted'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('CANCEL'),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text('OK'),
                    ),
                  ],
                ),
                // platform aware dialog
                // child: PlatformAlertDialog(
                //   title: 'Delete',
                //   content: '\"${task.title}\" will be deleted',
                //   defaultActionText: 'OK',
                //   cancelActionText: 'CANCEL',
                // ),
              );
            },
          );
        },
        child: SlidableDrawerDismissal(),
        // onDismissed: (actionType) async =>
        //     await _removeTask(context, task),
      ),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: GestureDetector(
        // onTap: () async => await _toggleDone(context, task),
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
          subtitle: Wrap(
            children: <Widget>[
              ...tags.map((tag) => Padding(
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
                          color: _appliedSlidableColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          // onTap: () => Navigator.pushNamed(
          //   context,
          //   RoutePath.writeTaskScreen,
          //   arguments: task,
          // ),
          color: Theme.of(context).accentColor,
          foregroundColor: _appliedSlidableColor,
          icon: Icons.edit,
          caption: 'Edit',
        ),
        IconSlideAction(
          onTap: () => appProvider.deleteMealWithTags(mealWithTags),
          //todo add alert and snack
          color: Theme.of(context).accentColor,
          foregroundColor: _appliedSlidableColor,
          icon: Icons.delete,
          caption: 'Delete',
        ),
      ],
    );
  }
}
