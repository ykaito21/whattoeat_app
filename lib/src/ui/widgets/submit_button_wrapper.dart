import 'package:flutter/material.dart';
import '../../core/providers/write_meal_screen_provider.dart';
import '../global/extensions.dart';
import '../shared/widgets/base_button.dart';
import '../shared/widgets/stream_wrapper.dart';

class SubmitButtonWrapper extends StatelessWidget {
  const SubmitButtonWrapper({Key key}) : super(key: key);

  Future<void> _onPressed(
    BuildContext context,
    bool isUpdated,
    WriteMealScreenProvider writeMealScreenProvider,
  ) async {
    final res = writeMealScreenProvider.onPressdButton(context, isUpdated);
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

  @override
  Widget build(BuildContext context) {
    final writeMealScreenProvider = context.provider<WriteMealScreenProvider>();
    return StreamWrapper<bool>(
      stream: writeMealScreenProvider.checkUpdate(),
      onError: (BuildContext context, _) {
        return BaseButton(
          onPressed: null,
          text: context.translate('error'),
        );
      },
      onWaitting: (BuildContext context) {
        return BaseButton(
          onPressed: null,
          text: context.translate('edit'),
        );
      },
      onSuccess: (BuildContext context, bool isUpdated) {
        return BaseButton(
          onPressed: () async =>
              await _onPressed(context, isUpdated, writeMealScreenProvider),
          text:
              isUpdated ? context.translate('save') : context.translate('edit'),
        );
      },
    );
  }
}
