import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/meals_screen_provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/services/database_service.dart';
import '../global/style_list.dart';
import '../shared/widgets/base_button.dart';
import '../shared/widgets/stream_wrapper.dart';
import '../widgets/tag_list.dart';
import '../widgets/search_bar.dart';
import '../widgets/meal_tile.dart';
import 'write_meal_screen_wrapper.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                onWaitting: (context) {
                  return Container();
                },
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
              Expanded(
                child: StreamWrapper<List<MealWithTags>>(
                  stream: appProvider.streamMealWithTags(
                    keywords: mealsScreenProvider.streamSearchKeywords,
                    tags: mealsScreenProvider.streamMealsScreenSelectedTags,
                  ),
                  onWaitting: (context) {
                    return Container();
                  },
                  onSuccess: (context, List<MealWithTags> mealWithTagsList) {
                    //todo improve
                    if (mealWithTagsList.isEmpty)
                      return Center(
                        child: Text('NO OPTION'),
                      );
                    return ListView.builder(
                      padding: StyleList.removePadding,
                      itemCount: mealWithTagsList.length,
                      itemBuilder: (context, index) {
                        final MealWithTags mealWithTags =
                            mealWithTagsList[index];
                        return MealTile(
                          mealWithTags: mealWithTags,
                        );
                      },
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: StyleList.horizontalPadding20,
                  child: BaseButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
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
