import 'package:flutter/material.dart';
import '../../core/providers/app_provider.dart';
import '../../core/providers/write_meal_screen_provider.dart';
import '../../core/services/database_service.dart';
import '../global/style_list.dart';
import '../global/extensions.dart';
import '../shared/widgets/base_text_field.dart';
import '../shared/widgets/stream_wrapper.dart';
import '../shared/platform/platform_alert_dialog.dart';
import '../widgets/submit_button_wrapper.dart';
import '../widgets/tag_list.dart';

class WriteMealScreen extends StatelessWidget {
  const WriteMealScreen({Key key}) : super(key: key);

  Future<void> _onPressedDelete(
    BuildContext context,
    AppProvider appProvider,
    MealWithTags currentMealWithTags,
  ) async {
    final mealName = currentMealWithTags.meal.name;
    final confirmation = await PlatformAlertDialog(
      title: context.localizeAlertTtile(mealName, 'alertDeleteTitle'),
      content: context.translate('alertDeleteContentMeal'),
      defaultActionText: context.translate('delete'),
      cancelActionText: context.translate('cancel'),
    ).show(context);
    if (confirmation) {
      appProvider.deleteMealWithTags(currentMealWithTags);
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          context.baseSnackBar(context.localizeMessage(mealName, 'wasDeleted')),
        );
      await Future.delayed(Duration(milliseconds: 1000), () => context.pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.provider<AppProvider>();
    final writeMealScreenProvider = context.provider<WriteMealScreenProvider>();
    final currentMealWithTags = writeMealScreenProvider.currentMealWithTags;
    // kToolbarHeight
    final appBarHeight = 56.0;
    // _kTabBarHeight
    // final double bottomNavHeight = 50.0;
    final wrapperHeight = context.height -
        (context.topPadding + context.bottomPadding + appBarHeight);
    final isNew = writeMealScreenProvider.isNew;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translateWithCondition(isNew, 'newMeal', 'editMeal'),
          style: StyleList.appBarTitleStyle,
        ),
      ),
      body: GestureDetector(
        onTap: () => context.unfocus,
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              height: wrapperHeight,
              child: Column(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 160.0,
                    ),
                    padding: StyleList.horizontalPadding20,
                    child: BaseTextField(
                      textEditingController:
                          writeMealScreenProvider.nameController,
                      onChanged: (String newVal) => writeMealScreenProvider
                          .checkTextFieldUpdate(newVal, 'name'),
                      hintText: context.translate('mealName'),
                      textStyle: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLength: 50,
                      focusNode: writeMealScreenProvider.nameFocusNode,
                    ),
                  ),
                  StyleList.verticalBox10,
                  Container(
                    height: 150.0,
                    child: StreamWrapper<List<Tag>>(
                      stream: appProvider.streamTags(),
                      onSuccess: (context, tags) {
                        return SingleChildScrollView(
                          padding: StyleList.verticalHorizontalpadding1020,
                          child: TagList(
                            tags: tags,
                            editable: true,
                            selectedTags: writeMealScreenProvider.initialTags,
                            provider: writeMealScreenProvider,
                          ),
                        );
                      },
                    ),
                  ),
                  StyleList.verticalBox10,
                  Expanded(
                    child: Padding(
                      padding: StyleList.horizontalPadding20,
                      child: BaseTextField(
                        textEditingController:
                            writeMealScreenProvider.noteController,
                        onChanged: (String newVal) => writeMealScreenProvider
                            .checkTextFieldUpdate(newVal, 'note'),
                        hintText: context.translate('note'),
                        textStyle: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  StyleList.verticalBox20,
                  Container(
                    height: 96,
                    padding: StyleList.horizontalPadding20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SubmitButtonWrapper(),
                        //* for snackbar
                        Builder(builder: (context) {
                          return FlatButton(
                            onPressed: isNew
                                ? null
                                : () async => await _onPressedDelete(
                                    context, appProvider, currentMealWithTags),
                            child: Text(
                              isNew ? '' : context.translate('delete'),
                              style: TextStyle(
                                color: context.accentColor,
                                fontSize: 20.0,
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
