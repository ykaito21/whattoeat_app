import 'package:flutter/material.dart';
import '../../core/providers/write_meal_screen_provider.dart';
import '../global/extensions.dart';
import '../shared/widgets/base_button.dart';

class SubmitButtonWrapper extends StatelessWidget {
  const SubmitButtonWrapper({Key key}) : super(key: key);

  Future<void> _onPressed(
    BuildContext context,
    bool isUpdated,
    WriteMealScreenProvider writeMealScreenProvider,
  ) async {
    if (!isUpdated) {
      context.requestFocus(writeMealScreenProvider.nameFocusNode);
    } else {
      final res = writeMealScreenProvider.updateMealWithTags();
      if (res) {
        Scaffold.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
            context.baseSnackBar(
              context.localizeMessage(
                  writeMealScreenProvider.nameController.text, 'wasSaved'),
            ),
          );
        await Future.delayed(Duration(milliseconds: 1000), () => context.pop());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final writeMealScreenProvider = context.provider<WriteMealScreenProvider>();
    return StreamBuilder<bool>(
      stream: writeMealScreenProvider.checkUpdate(),
      builder: (context, snapshot) {
        return BaseButton(
          onPressed: !snapshot.hasData
              ? null
              : () async => await _onPressed(
                  context, snapshot.data, writeMealScreenProvider),
          text: !snapshot.hasData
              ? context.translate('edit')
              : snapshot.data
                  ? context.translate('save')
                  : context.translate('edit'),
        );
      },
    );
  }
}
