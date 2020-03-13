import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import '../../core/services/database_service.dart' as db;
import '../global/extensions.dart';
import '../shared/platform/platform_alert_dialog.dart';

class TagList extends StatelessWidget {
  final List<db.Tag> tags;
  final provider;
  final bool editable;
  final List<db.Tag> selectedTags;

  TagList({
    Key key,
    @required this.tags,
    @required this.provider,
    this.editable = false,
    this.selectedTags = const [],
  })  : assert(tags != null),
        assert(provider != null),
        super(key: key);

  Future<void> _onLongPressed(BuildContext context, db.Tag tag) async {
    final confirmation = await PlatformAlertDialog(
      title: context.localizeAlertTtile(tag.name, 'alertDeleteTitle'),
      content: context.translate('alertDeleteContentTag'),
      defaultActionText: context.translate('delete'),
      cancelActionText: context.translate('cancel'),
    ).show(context);
    if (confirmation) {
      await provider.onRemoveTag(tag);
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          context.baseSnackBar(context.localizeMessage(tag.name, 'wasDeleted')),
        );
      //! bug cannot add the same tag if deleted it at the same screen
    }
  }

  @override
  Widget build(BuildContext context) {
    //* can use state key
    // final tagStatekey = GlobalObjectKey<TagsState>(context);
    return Tags(
      // key: tagStatekey,
      itemCount: tags.length,
      textField: _tagsTextField(context),
      itemBuilder: (int index) {
        final db.Tag tag = tags[index];
        return ItemTags(
          onPressed: (item) {
            // if using statekey
            // final allItems = tagStatekey.currentState?.getAllItem;
            // if (allItems != null) allItems.where((item) => item.active);
            provider.onPressedTag(item.customData, item.active);
          },
          key: UniqueKey(),
          index: index,
          title: tag.name,
          active: selectedTags.contains(tag) ? true : false,
          customData: tag,
          elevation: 2,
          border: Border.all(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(30),
          // border: Border.all(color: context.accentColor),
          color: context.isDarkMode ? Colors.grey[700] : Colors.grey[200],
          activeColor: context.accentColor,
          textColor: context.isDarkMode ? Colors.white : Colors.black,
          textActiveColor: context.isDarkMode ? Colors.black : Colors.white,
          textStyle: TextStyle(
            fontSize: 16,
          ),
          removeButton: editable
              ? ItemTagsRemoveButton(
                  backgroundColor:
                      context.isDarkMode ? Colors.grey[700] : Colors.grey[200],
                  color: context.accentColor,
                )
              : null,
          onLongPressed: editable
              ? (item) async => _onLongPressed(context, item.customData)
              : null,
        );
      },
    );
  }

  TagsTextField _tagsTextField(BuildContext context) {
    return editable
        ? TagsTextField(
            onSubmitted: provider.onSubmitTag,
            autofocus: false,
            hintText: context.translate('newTag'),
            helperText: ' ',
            width: 80.0,
            maxLength: 20,
            textStyle: TextStyle(
              fontSize: 16.0,
            ),
            inputDecoration: InputDecoration(
              counterText: '',
              //* to remove bottom padding
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: context.accentColor,
                ),
              ),
            ),
          )
        : null;
  }
}
