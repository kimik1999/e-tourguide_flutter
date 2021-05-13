import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ConnectionWidget extends StatefulWidget {
  String type;
  ConnectionWidget({this.type});
  @override
  _ConnectionWidgetState createState() => _ConnectionWidgetState();
}

class _ConnectionWidgetState extends State<ConnectionWidget> {
  String status = "";
  Color color = Colors.white;
  @override
  void initState() {
    CheckStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }

    return Container(
      color: color,
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Text(
        status != null ? status : "",
        style:
            TextStyle(color: Colors.white, fontFamily: "Helve", fontSize: 14),
      ),
    );
  }

  void CheckStatus() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        ChangeValues(null, Colors.white);
      } else {
        ChangeValues('no_internet'.tr(), Colors.red);
      }
    });
  }

  void ChangeValues(String resultvalue, Color colorvalue) {
    setState(() {
      status = resultvalue;
      color = colorvalue;
    });
  }
}
