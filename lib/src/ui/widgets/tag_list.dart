import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import '../../core/services/database_service.dart' as db;
import '../../ui/global/color_list.dart';

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

  @override
  Widget build(BuildContext context) {
    return Tags(
      itemCount: tags.length,
      textField: _tagsTextField(context),
      itemBuilder: (int index) {
        final db.Tag tag = tags[index];
        final bool isDarkMode =
            Theme.of(context).primaryColor == ColorList.primaryCream;
        return ItemTags(
          onPressed: (item) =>
              provider.onPressedTag(item.customData, item.active),
          key: UniqueKey(),
          index: index,
          title: tag.name,
          active: selectedTags.contains(tag) ? true : false,
          customData: tag,
          elevation: 2,
          border: Border.all(style: BorderStyle.none),
          borderRadius: BorderRadius.circular(30),
          // border: Border.all(color: Theme.of(context).accentColor),
          color: isDarkMode ? Colors.grey[200] : Colors.grey[700],
          activeColor: Theme.of(context).accentColor,
          textColor: isDarkMode ? Colors.black : Colors.white,
          textActiveColor: isDarkMode ? Colors.white : Colors.black,
          textStyle: TextStyle(
            fontSize: 16,
          ),
          removeButton: editable
              ? ItemTagsRemoveButton(
                  backgroundColor:
                      isDarkMode ? Colors.grey[200] : Colors.grey[700],
                  color: Theme.of(context).accentColor,
                )
              : null,
          //todo need alert or snackbar
          onRemoved: () => provider.onRemoveTag(tag),
        );
      },
    );
  }

  TagsTextField _tagsTextField(context) {
    return editable
        ? TagsTextField(
            //todo need alert or snackbar
            onSubmitted: provider.onSubmitTag,
            autofocus: false,
            //todo i18n
            hintText: 'New Tag',
            helperText: ' ',
            width: 80.0,
            maxLength: 10,
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
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          )
        : null;
  }
}
