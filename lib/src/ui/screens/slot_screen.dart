import 'package:flutter/material.dart';
import '../../core/providers/slot_screen_provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/services/database_service.dart';
import '../global/style_list.dart';
import '../global/extensions.dart';
import '../shared/widgets/base_button.dart';
import '../shared/widgets/stream_wrapper.dart';
import '../widgets/tag_list.dart';
import '../widgets/slot_display.dart';

class SlotScreen extends StatelessWidget {
  const SlotScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appProvider = context.provider<AppProvider>();
    final slotScreenProvider = context.provider<SlotScreenProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: _appBarTitle(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Padding(
              padding: StyleList.horizontalPadding20,
              child: SlotDisplay(),
            ),
            StyleList.verticalBox10,
            Expanded(
              child: StreamWrapper<List<Tag>>(
                stream: appProvider.streamTags(),
                onWaitting: (context) {
                  return Container();
                },
                onSuccess: (context, List<Tag> tags) {
                  return SingleChildScrollView(
                    padding: StyleList.verticalHorizontalpadding1020,
                    child: TagList(
                      tags: tags,
                      provider: slotScreenProvider,
                    ),
                  );
                },
              ),
            ),
            StyleList.verticalBox10,
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: StyleList.horizontalPadding20,
                child: BaseButton(
                  onPressed: slotScreenProvider.slotStart,
                  text: context.translate('spin'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _appBarTitle(BuildContext context) {
    return <Widget>[
      Text(
        context.translate('appTitleFirst'),
        style: StyleList.appBarTitleStyle,
      ),
      ClipRect(
        child: Container(
          child: Align(
            alignment: Alignment.center,
            heightFactor: 0.6,
            child: Text(
              context.translate('appTitleSecond'),
              style: StyleList.appBarTitleStyle.copyWith(
                height: 0.9,
              ),
            ),
          ),
        ),
      ),
      Text(
        context.translate('appTitleThird'),
        style: StyleList.appBarTitleStyle,
      ),
    ];
  }
}
