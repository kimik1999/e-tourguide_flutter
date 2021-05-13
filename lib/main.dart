import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etouguide_view/bottom_navigation_view.dart';
import 'package:flutter_etourguide/etouguide_view/launcherpage_view.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  //await EasyLocalization.ensure;
  runApp(EasyLocalization(
      supportedLocales: [
        Locale('vi', 'VN'),
        Locale('en', 'US'),
      ],
      fallbackLocale: Locale('vi', 'VN'),
      saveLocale: true,
      path: 'assets/localizations',
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    String type = "";
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListEventViewModel()),
        ChangeNotifierProvider(create: (_) => ListExhibitViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        //locale: context.locale,
        title: 'Flutter Etourguide',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: <String, WidgetBuilder>{
          '/BottomNavMap': (BuildContext context) => new BottomNavigationView(
                index_setting: 3,
                type: type,
                args: ModalRoute.of(context).settings.arguments,
              ),
        },
        home: LauncherPageView(),
      ),
    );
  }
}
