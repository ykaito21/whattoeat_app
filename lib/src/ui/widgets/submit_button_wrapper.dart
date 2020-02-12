import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/write_meal_screen_provider.dart';
import '../global/style_list.dart';
import '../shared/widgets/base_button.dart';
import '../shared/widgets/stream_wrapper.dart';

class SubmitButtonWrapper extends StatelessWidget {
  const SubmitButtonWrapper({Key key}) : super(key: key);

  Future<void> _onPressed(
    BuildContext context,
    bool isUpdated,
    WriteMealScreenProvider writeMealScreenProvider,
  ) async {
    final bool res = writeMealScreenProvider.onPressdButton(context, isUpdated);
    if (res) {
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          //todo 18n
          StyleList.baseSnackBar(context, 'Meal was successfully saved'),
        );
      await Future.delayed(
          Duration(milliseconds: 1500), () => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final WriteMealScreenProvider writeMealScreenProvider =
        Provider.of<WriteMealScreenProvider>(context, listen: false);
    return StreamWrapper<bool>(
      stream: writeMealScreenProvider.checkUpdate(),
      onError: (context, _) {
        return BaseButton(
          onPressed: null,
          text: 'Error',
        );
      },
      onWaitting: (context) {
        return BaseButton(
          onPressed: null,
          text: 'Edit',
        );
      },
      onSuccess: (context, isUpdated) {
        return BaseButton(
          onPressed: () async =>
              await _onPressed(context, isUpdated, writeMealScreenProvider),
          //todo i18n
          text: isUpdated ? 'Save' : 'Edit',
        );
      },
    );
  }
}
