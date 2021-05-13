import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etouguide_view/animation/FadeAnimation.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_widget/language_widget.dart';
import 'package:provider/provider.dart';

class LauncherPageView extends StatefulWidget {
  @override
  _LauncherPageViewState createState() => _LauncherPageViewState();
}

class _LauncherPageViewState extends State<LauncherPageView> {
  @override
  void didUpdateWidget(covariant LauncherPageView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    //CheckInternet().listener.cancel();
    super.dispose();
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListEventViewModel()),
        ChangeNotifierProvider(create: (_) => ListExhibitViewModel()),
      ],
      child: Scaffold(
        body: Stack(children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white),
            child: FadeAnimation(
              3,
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: ColorizeAnimatedTextKit(
                  onTap: () {
                    //print("Tap Event");
                  },
                  text: ["E-TOUR GUIDE"],
                  textStyle: TextStyle(
                      fontSize: 35.0,
                      fontFamily: "Horizon",
                      fontWeight: FontWeight.bold),
                  colors: [
                    kPrimaryColor,
                    Colors.white,
                    kPrimaryColor,
                  ],
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            bottom: MediaQuery.of(context).size.height * 0.35,
            child: FadeAnimation(
              3.5,
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: FadeAnimation(
                1.8,
                Container(
                  width: 161,
                  height: 245,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/theme1.png"),
                          fit: BoxFit.fill)),
                ),
              )),
          Positioned(
              bottom: 0,
              left: 0,
              child: FadeAnimation(
                2.5,
                Container(
                  width: 161,
                  height: 235,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/theme2.png"),
                          fit: BoxFit.fill)),
                ),
              )),
        ]),
      ),
    );
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LanguageWidget()));
  }
}
