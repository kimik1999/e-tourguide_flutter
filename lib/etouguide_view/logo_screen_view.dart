import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etouguide_view/animation/FadeAnimation.dart';
import 'package:flutter_etourguide/etouguide_view/bottom_navigation_view.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class LogoScreenView extends StatefulWidget {
  String localization;
  LogoScreenView({this.localization});
  @override
  _LogoScreenViewState createState() => _LogoScreenViewState();
}

class _LogoScreenViewState extends State<LogoScreenView> {
  var currentTime = DateTime.now().hour;
  var endTime = 24;
  var startTime = 7;
  String value = "";
  @override
  void initState() {
    setState(() {
      checkConnection();
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LogoScreenView oldWidget) {
    setState(() {
      checkConnection();
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.localization != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListEventViewModel()),
        ChangeNotifierProvider(create: (_) => ListExhibitViewModel()),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 1,
                        child: FadeAnimation(
                          1.3,
                          Container(
                            width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/tree1_vector.png"),
                                    fit: BoxFit.fitHeight)),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: FadeAnimation(
                          1.6,
                          Container(
                            width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/tree1_vector.png"),
                                    fit: BoxFit.fitHeight)),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: FadeAnimation(
                          1.9,
                          Container(
                            width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/tree1_vector.png"),
                                    fit: BoxFit.fitHeight)),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: FadeAnimation(
                          2.2,
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.18,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/museum_vec.png"),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: FadeAnimation(
                          2.5,
                          Container(
                            width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/tree1_vector.png"),
                                    fit: BoxFit.fitHeight)),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: FadeAnimation(
                          2.8,
                          Container(
                            width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.height * 0.12,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/tree1_vector.png"),
                                    fit: BoxFit.fitHeight)),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: FadeAnimation(
                          3.2,
                          Container(
                            width: MediaQuery.of(context).size.width * 0.11,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/tree1_vector.png"),
                                    fit: BoxFit.fitHeight)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FadeAnimation(
                    4.2,
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        'introduce',
                        style: TextStyle(
                            fontFamily: 'Helve',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ).tr(),
                    )),
                FadeAnimation(
                    4.3,
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.all(15),
                      child: Text(
                        'script',
                        style: TextStyle(fontFamily: 'Helve', fontSize: 16),
                        textAlign: TextAlign.center,
                      ).tr(),
                    )),
                FadeAnimation(
                  4.7,
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.55,
                    margin: EdgeInsets.only(top: 20, bottom: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                              color: kPrimaryColor,
                              blurRadius: 3,
                              offset: Offset(2, 2))
                        ]),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          checkConnection();
                          if (value.contains("disconnected")) {
                            _showDialog('no_internet'.tr(),
                                'no_internet_notified'.tr());
                          } else {
                            if (currentTime > endTime ||
                                currentTime < startTime) {
                              _showDialog(
                                  'note_label'.tr(), 'system_notified'.tr());
                            }
                            else {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return BottomNavigationView(
                                  type: widget.localization,
                                  args: null,
                                );
                              }));
                            }
                          }
                        });
                      },
                      child: Text(
                        'continues',
                        style: TextStyle(
                            fontFamily: 'Helve',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ).tr(),
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  void _showDialog(String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
//                      SystemNavigator.pop();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: new Text(
                    'ok_button',
                    style: TextStyle(fontFamily: "Helve", color: kPrimaryColor),
                  ).tr(),
                )
              ]);
        });
  }

  checkConnection() {
    DataConnectionChecker().connectionStatus.then((status) {
      setState(() {
        value = status.toString().split('.')[1];
      });
    });
    return DataConnectionChecker().connectionStatus;
  }
}
