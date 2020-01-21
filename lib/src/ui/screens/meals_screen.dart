import 'package:flutter/material.dart';
import 'package:whattoeat_app/src/ui/screens/write_meal_screen.dart';
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
            StyleList.verticalBox10,
            Container(
              // height: 100.0,
              // padding: StyleList.horizontalPadding10,
              child: SingleChildScrollView(
                padding: StyleList.horizontalPadding20,
                scrollDirection: Axis.horizontal,
                child: TagList(),
              ),
            ),
            StyleList.verticalBox10,
            Expanded(
              child: Container(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0.0),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      //* if using floating action button need maring
                      // margin: index == 9 ? StyleList.bottomPadding50 : null,
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: ListTile(
                        onTap: () {},
                        title: Text('Test'),
                      ),
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
                      rootNavigator: true,
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
