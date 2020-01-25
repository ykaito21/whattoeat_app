import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../global/color_list.dart';
import 'write_meal_screen.dart';
import '../shared/widgets/base_button.dart';
import '../widgets/tag_list.dart';
import '../global/style_list.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Meal List',
          style: StyleList.appBarTitleStyle,
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Padding(
              padding: StyleList.horizontalPadding20,
              child: TextField(
                cursorColor: Theme.of(context).accentColor,
                decoration: InputDecoration(
                  contentPadding: StyleList.horizontalPadding20,
                  hintText: 'Meal Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: true
                        ? Icon(
                            Icons.search,
                            // color: Theme.of(context).accentColor,
                          )
                        : Icon(
                            Icons.clear,
                            // color: Theme.of(context).accentColor,
                          ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              scrollDirection: Axis.horizontal,
              child: TagList(),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0.0),
                  itemCount: 10,
                  // separatorBuilder: (BuildContext context, int index) =>
                  //     Divider(
                  //   color: Theme.of(context).accentColor,
                  // ),
                  itemBuilder: (context, index) {
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
                        Theme.of(context).primaryColor == ColorList.primaryCream
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
                                  Theme.of(context).primaryColor == Colors.white
                                      ? Colors.black
                                      : Colors.white;

                              ;
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
                                  accentColor: Theme.of(context).accentColor,
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
                                  content: Text('\"test\" will be deleted'),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
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
                          title: Text(
                            'パイ包み焼きサラダを添えて',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text('夕食, スープ, 大根'),
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
                          // onTap: () async => await _removeTask(context, task),
                          color: Theme.of(context).accentColor,
                          foregroundColor: _appliedSlidableColor,
                          icon: Icons.delete,
                          caption: 'Delete',
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: StyleList.horizontalPadding20,
                child: BaseButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                      // rootNavigator: true,
                    ).push(
                      MaterialPageRoute(
                        builder: (context) => WriteMealScreen(),
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
      // floatingActionButton: Container(
      //   width: deviceWidth,
      //   padding: StyleList.horizontalPadding10,
      //   child: BaseButton(
      //     onPressed: () {},
      //     text: 'Add',
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
