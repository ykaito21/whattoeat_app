import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../core/providers/meals_screen_provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/services/database_service.dart';
import '../global/color_list.dart';
import '../global/style_list.dart';
import '../shared/widgets/base_button.dart';
import '../shared/widgets/stream_wrapper.dart';
import '../widgets/tag_list.dart';
import '../widgets/search_bar.dart';
import 'write_meal_screen_wrapper.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //todo improve layout
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    final MealsScreenProvider mealsScreenProvider =
        Provider.of<MealsScreenProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Meal List',
          style: StyleList.appBarTitleStyle,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Padding(
                padding: StyleList.horizontalPadding20,
                child: SearchBar(),
              ),
              StreamWrapper<List<Tag>>(
                stream: appProvider.streamTags(),
                //TODO solve waiting things
                //todo highlight matched tags
                onSuccess: (context, List<Tag> tags) {
                  return SingleChildScrollView(
                    padding: StyleList.verticalHorizontalPaddding1020,
                    scrollDirection: Axis.horizontal,
                    child: TagList(
                      tags: tags,
                      provider: mealsScreenProvider,
                    ),
                  );
                },
              ),
              StreamWrapper<List<MealWithTags>>(
                  stream: appProvider.streamMealWithTags(
                    keywords: mealsScreenProvider.streamSearchKeywords,
                    tags: mealsScreenProvider.streamMealsScreenSelectedTags,
                  ),
                  onSuccess: (context, List<MealWithTags> mealWithTagsList) {
                    //todo improve
                    if (mealWithTagsList.isEmpty)
                      return Expanded(
                        child: Center(
                          child: Text('NO OPTION'),
                        ),
                      );
                    return Expanded(
                      child: ListView.builder(
                        padding: StyleList.removePadding,
                        itemCount: mealWithTagsList.length,
                        // separatorBuilder: (BuildContext context, int index) =>
                        //     Divider(
                        //   color: Theme.of(context).accentColor,
                        // ),
                        itemBuilder: (context, index) {
                          //todo
                          final MealWithTags mealWithTags =
                              mealWithTagsList[index];
                          final mealName = mealWithTags.meal.name;
                          final tags = mealWithTags.tags
                              .map((tag) => tag.name)
                              .toList()
                              .toString();
                          // return Container(
                          //   //* if using floating action button need maring
                          //   // margin: index == 9 ? StyleList.bottomPadding50 : null,
                          //   decoration: BoxDecoration(
                          //     border: Border.all(),
                          //   ),
                          //   child: ListTile(
                          //     onTap: () {},
                          //     title: Text('Test'),
                          //   ),
                          // );
                          final Color _appliedSlidableColor =
                              Theme.of(context).primaryColor ==
                                      ColorList.primaryCream
                                  ? Colors.white
                                  : Colors.black;
                          return Slidable(
                            key: Key(UniqueKey().toString()),
                            dismissal: SlidableDismissal(
                              onWillDismiss: (actionType) {
                                return showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    final Color _appliedColor =
                                        Theme.of(context).primaryColor ==
                                                Colors.white
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
                                          primaryVariant:
                                              Theme.of(context).accentColor,
                                          secondary: Colors.black,
                                          secondaryVariant: Colors.black,
                                          surface: Colors.white,
                                        ),
                                        accentColor:
                                            Theme.of(context).accentColor,
                                        dialogBackgroundColor:
                                            Theme.of(context).primaryColor,
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
                                        content:
                                            Text('\"test\" will be deleted'),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: Text('CANCEL'),
                                          ),
                                          FlatButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
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
                                  Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WriteMealScreenWrapper(
                                              mealWithTags: mealWithTags),
                                    ),
                                  );
                                },
                                contentPadding: StyleList.horizontalPadding20,
                                title: Text(
                                  mealName,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(tags),
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
                                onTap: () => appProvider
                                    .deleteMealWithTags(mealWithTags),
                                //todo add alert and snack
                                color: Theme.of(context).accentColor,
                                foregroundColor: _appliedSlidableColor,
                                icon: Icons.delete,
                                caption: 'Delete',
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: StyleList.horizontalPadding20,
                  child: BaseButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).push(
                        MaterialPageRoute(
                          builder: (context) => WriteMealScreenWrapper(),
                        ),
                      );
                    },
                    text: 'Add',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
