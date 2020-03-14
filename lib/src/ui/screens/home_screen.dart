import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/home_screen_provider.dart';
import '../global/routes/route_generator.dart';
import '../global/extensions.dart';
import 'meals_screen_wrapper.dart';
import 'slot_screen_wrapper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<HomeScreenProvider>(
      create: (context) => HomeScreenProvider(),
      dispose: (context, homeScreenProvider) => homeScreenProvider.dispose(),
      child: Consumer<HomeScreenProvider>(
          builder: (context, homeScreenProvider, child) {
        return WillPopScope(
          onWillPop: () async => !await homeScreenProvider
              .navigators[homeScreenProvider.currentIndex].currentState
              .maybePop(),
          child: CupertinoTabScaffold(
            resizeToAvoidBottomInset: false,
            tabBuilder: (context, index) {
              return CupertinoTabView(
                navigatorKey: homeScreenProvider.navigators[index],
                onGenerateRoute: RouteGenerator.generateRoute,
                builder: (context) {
                  switch (index) {
                    case 0:
                      return SlotScreenWrapper();
                    case 1:
                      return MealsScreenWrapper();
                    default:
                      return Container();
                  }
                },
              );
            },
            tabBar: CupertinoTabBar(
              border: Border(
                top: BorderSide(
                  color: context.primaryColor,
                  width: 0.0, // One physical pixel.
                  style: BorderStyle.solid,
                ),
              ),
              backgroundColor: context.scaffoldBackgroundColor,
              activeColor: context.accentColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  // title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.view_list),
                ),
              ],
              onTap: (index) {
                if (homeScreenProvider.currentIndex == index) {
                  homeScreenProvider.navigators[index].currentState
                      .popUntil((route) => route.isFirst);
                }
                homeScreenProvider.currentIndex = index;
              },
            ),
          ),
        );
      }),
    );
  }
}
