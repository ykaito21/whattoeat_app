import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whattoeat_app/src/ui/shared/widgets/base_button.dart';
import 'package:whattoeat_app/src/ui/widgets/tag_list.dart';
import '../global/style_list.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final baseWidth = deviceWidth * 0.9;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meal List',
          style: StyleList.appBarTitleStyle,
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                // vertical: 5.0,
                horizontal: 10.0,
              ),
              decoration: BoxDecoration(),
              child: TextField(
                cursorColor: Theme.of(context).accentColor,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  hintText: 'Meal Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        30.0,
                      ),
                    ),
                    borderSide: BorderSide(),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        30.0,
                      ),
                    ),
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: true
                        ? Icon(
                            FontAwesomeIcons.search,
                            // color: Theme.of(context).accentColor,
                          )
                        : Icon(
                            FontAwesomeIcons.times,
                            // color: Theme.of(context).accentColor,
                          ),
                  ),
                ),
              ),
            ),
            StyleList.verticalBox10,
            Container(
              height: 100.0,
              padding: StyleList.horizontalPadding10,
              child: SingleChildScrollView(
                // scrollDirection: Axis.horizontal,
                child: TagList(),
              ),
            ),
            StyleList.verticalBox10,
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text('Test'));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: baseWidth,
        padding: StyleList.verticalPadding20,
        child: BaseButton(
          onPressed: () {},
          text: 'Add',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
