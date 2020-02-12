import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/slot_screen_provider.dart';
import '../../core/providers/app_provider.dart';
import '../../core/services/database_service.dart';
import '../widgets/tag_list.dart';
import '../widgets/slot_display.dart';
import '../shared/widgets/base_button.dart';
import '../shared/widgets/stream_wrapper.dart';
import '../global/style_list.dart';

class SlotScreen extends StatelessWidget {
  const SlotScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //todo ia8n
    final AppProvider appProvider =
        Provider.of<AppProvider>(context, listen: false);
    final SlotScreenProvider slotScreenProvider =
        Provider.of<SlotScreenProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: _appBarTitle(),
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
                    padding: StyleList.verticalHorizontalPaddding1020,
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
                  text: 'Spin',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _appBarTitle() {
    return <Widget>[
      Text(
        'What',
        style: StyleList.appBarTitleStyle,
      ),
      ClipRect(
        child: Container(
          child: Align(
            alignment: Alignment.center,
            heightFactor: 0.6,
            child: Text(
              '2\n2',
              style: StyleList.appBarTitleStyle.copyWith(
                height: 0.9,
              ),
            ),
          ),
        ),
      ),
      Text(
        'Eat',
        style: StyleList.appBarTitleStyle,
      ),
    ];
  }
}
