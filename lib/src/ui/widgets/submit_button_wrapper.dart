import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_localizations.dart';
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
          StyleList.baseSnackBar(
              context, AppLocalizations.of(context).translate('wasSaved')),
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
          text: AppLocalizations.of(context).translate('error'),
        );
      },
      onWaitting: (context) {
        return BaseButton(
          onPressed: null,
          text: AppLocalizations.of(context).translate('edit'),
        );
      },
      onSuccess: (context, isUpdated) {
        return BaseButton(
          onPressed: () async =>
              await _onPressed(context, isUpdated, writeMealScreenProvider),
          //todo i18n
          text: isUpdated
              ? AppLocalizations.of(context).translate('save')
              : AppLocalizations.of(context).translate('edit'),
        );
      },
    );
  }
}
