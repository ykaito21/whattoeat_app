import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    final WriteMealScreenProvider writeMealScreenProvider =
        Provider.of<WriteMealScreenProvider>(context, listen: false);

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
          isNew ? 'New Meal' : 'Edit Meal',
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
                      hintText: 'Meal Name',
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
                        hintText: 'Note',
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
                              : () {
                                  appProvider.deleteMealWithTags(
                                      writeMealScreenProvider
                                          .currentMealWithTags);
                                  //todo alert snack
                                },
                          child: Text(
                            isNew ? '' : 'Delete',
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
