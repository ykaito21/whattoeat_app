import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/write_meal_screen_provider.dart';
import '../shared/widgets/base_button.dart';
import '../shared/widgets/stream_wrapper.dart';

class SubmitButtonWrapper extends StatelessWidget {
  const SubmitButtonWrapper({Key key}) : super(key: key);

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
          onPressed: () {
            writeMealScreenProvider.onPressdButton(context, isUpdated);
          },
          text: writeMealScreenProvider.currentButtonText(isUpdated),
        );
      },
    );
  }
}
