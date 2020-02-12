import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whattoeat_app/src/ui/shared/platform/platform_alert_dialog.dart';
import '../../app_localizations.dart';
import '../../core/providers/app_provider.dart';
import '../../core/providers/write_meal_screen_provider.dart';
import '../../core/services/database_service.dart';
import '../shared/widgets/base_text_field.dart';
import '../shared/widgets/stream_wrapper.dart';
import '../widgets/submit_button_wrapper.dart';
import '../widgets/tag_list.dart';
import '../global/style_list.dart';

class WriteMealScreen extends StatelessWidget {
  const WriteMealScreen({Key key}) : super(key: key);

  Future<void> _onPressedDelete(
    BuildContext context,
    AppProvider appProvider,
    MealWithTags currentMealWithTags,
  ) async {
    final String mealName = currentMealWithTags.meal.name;
    final bool res = await PlatformAlertDialog(
      title:
          '${AppLocalizations.of(context).translate('alertDeleteTitle')} "$mealName"${AppLocalizations.of(context).translate('questionMark')}',
      content:
          '$mealName ${AppLocalizations.of(context).translate('alertDeleteContentMeal')}',
      defaultActionText: AppLocalizations.of(context).translate('yes'),
      cancelActionText: AppLocalizations.of(context).translate('no'),
    ).show(context);
    if (res) {
      appProvider.deleteMealWithTags(currentMealWithTags);
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          StyleList.baseSnackBar(context,
              '"$mealName" ${AppLocalizations.of(context).translate('wasDeleted')}'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    final WriteMealScreenProvider writeMealScreenProvider =
        Provider.of<WriteMealScreenProvider>(context, listen: false);
    final MealWithTags currentMealWithTags =
        writeMealScreenProvider.currentMealWithTags;

    final double deviseHeight = MediaQuery.of(context).size.height;
    final double topPadding = MediaQuery.of(context).padding.top;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    // kToolbarHeight
    final double appBarHeight = 56.0;
    // _kTabBarHeight
    // final double bottomNavHeight = 50.0;
    final double wrapperHeight =
        deviseHeight - (topPadding + bottomPadding + appBarHeight);
    final bool isNew = writeMealScreenProvider.isNew();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNew
              ? AppLocalizations.of(context).translate('newMeal')
              : AppLocalizations.of(context).translate('editMeal'),
          style: StyleList.appBarTitleStyle,
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
                      hintText:
                          AppLocalizations.of(context).translate('mealName'),
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
                      onSuccess: (context, List<Tag> tags) {
                        return SingleChildScrollView(
                          padding: StyleList.verticalHorizontalPaddding1020,
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
                        hintText:
                            AppLocalizations.of(context).translate('note'),
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
                        FlatButton(
                          onPressed: isNew
                              ? null
                              : () async => await _onPressedDelete(
                                  context, appProvider, currentMealWithTags),
                          child: Text(
                            isNew
                                ? ''
                                : AppLocalizations.of(context)
                                    .translate('delete'),
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 20.0,
                            ),
                          ),
                        )
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
