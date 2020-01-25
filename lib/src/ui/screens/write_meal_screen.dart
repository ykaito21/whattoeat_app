import 'package:flutter/material.dart';
import 'package:whattoeat_app/src/ui/shared/widgets/base_button.dart';
import '../widgets/tag_list.dart';
import '../global/style_list.dart';

class WriteMealScreen extends StatelessWidget {
  const WriteMealScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Meal',
          style: StyleList.appBarTitleStyle,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 250.0,
                  ),
                  padding: StyleList.horizontalPadding20,
                  child: TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      hintText: 'Meal Title',
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    cursorColor: Theme.of(context).accentColor,
                    style: TextStyle(
                      fontSize: 48.0,
                    ),
                  ),
                ),
                StyleList.verticalBox20,
                Container(
                  height: 200.0,
                  child: SingleChildScrollView(
                    padding: StyleList.horizontalPadding20,
                    child: TagList(),
                  ),
                ),
                StyleList.verticalBox20,
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 250.0,
                  ),
                  padding: StyleList.horizontalPadding20,
                  child: TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      hintText: 'Memo',
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    cursorColor: Theme.of(context).accentColor,
                    style: TextStyle(),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: StyleList.horizontalPadding20,
                  child: BaseButton(
                    onPressed: () {},
                    text: 'Save Edit',
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: StyleList.horizontalPadding20,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
