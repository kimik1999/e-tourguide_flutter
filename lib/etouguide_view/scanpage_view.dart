import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etourguide_model/route_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/position_text_vm_api.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_vm_api.dart';
import 'package:provider/provider.dart';

class ScanPageView extends StatefulWidget {
  String type;
  ScanPageView({this.type});
  @override
  _ScanPageViewState createState() => _ScanPageViewState();
}

class _ScanPageViewState extends State<ScanPageView> {

  String _scanBarcode = 'scan_err_label'.tr();
  List<RouteModel> routeModel = [];
  Future<void> scanQR() async {
    try {
      await FlutterBarcodeScanner.scanBarcode(
              "#ff6666", 'cancel_button'.tr(), true, ScanMode.QR)
          .then((value) {
        try {
          int scan_value = int.parse(value);
          if (scan_value > 0) {
            RouteViewModel args = ModalRoute.of(context).settings.arguments;
            int floor = 0;
            if (scan_value <= 27) {
              floor = 1;
            } else {
              floor = 2;
            }

            if (args != null && args.listRoute != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Provider.of<RouteVMApi>(context, listen: false)
                    .suggestBackToStartPoint(scan_value)
                    .then((listRoute) {
                  routeModel = listRoute;
                  //print(args.listRoute.length);
                  int startPoint = routeModel[0].listRoute[0];
//                  print("equal index:${args.listRoute.indexOf(startPoint)}");
                  int start = 0;
                  int end = args.listRoute.indexOf(startPoint);
                  if(end != -1){
                    args.listRoute.removeRange(start, end);
                  } else {
                    args.listRoute.clear();
                  }
//                  for (int i = 0; i < args.listRoute.length; i++) {
//                    print("list:");
//                    print(args.listRoute[i]);
//                  }

                  //check list length again
                  if(args.listRoute.length > 0){
                    final languageVi = "vi";
                    Provider.of<PositionTextVMApi>(context, listen: false)
                        .getTextByPosition(widget.type != null ? widget.type : languageVi, args.listRoute)
                        .then((text) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/BottomNavMap', (Route<dynamic> route) => false,
                          arguments: RouteViewModel(
                              route: RouteModel(
                                  type: widget.type,
                                  scan: value,
                                  text: text,
                                  listRoute: args.listRoute,
                                  floor: floor)));
                    });

                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/BottomNavMap', (Route<dynamic> route) => false,
                        arguments: RouteViewModel(
                            route: RouteModel(
                                type: widget.type,
                                scan: value,
                                listRoute: routeModel[0].listRoute,
                                text: widget.type != null
                                    ? routeModel[0].textRouteEng
                                    : routeModel[0].textRouteVi,
                                floor: floor)));
                  }
                });
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Provider.of<RouteVMApi>(context, listen: false)
                    .suggestBackToStartPoint(scan_value)
                    .then((listRoute) {
                  routeModel = listRoute;
                  //no view route before
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/BottomNavMap', (Route<dynamic> route) => false,
                      arguments: RouteViewModel(
                          route: RouteModel(
                              type: widget.type,
                              scan: value,
                              listRoute: routeModel[0].listRoute,
                              text: widget.type != null
                                  ? routeModel[0].textRouteEng
                                  : routeModel[0].textRouteVi,
                              floor: floor)));
                });
              });

            }
          }
        } on FormatException {
          showAlertDialog(context, _scanBarcode);
        }
      });
    } on Exception {
      showAlertDialog(this.context, _scanBarcode);
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(top: 150.0),
              child: Icon(
                Icons.qr_code_scanner_rounded,
                size: 250,
                color: kPrimaryColor,
              ),
            ),
            InkWell(
                onTap: () => scanQR(),
                child: Container(
                  //margin: EdgeInsets.only(top: 100.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0, 20.0),
                          blurRadius: 30.0,
                          color: Colors.black12,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Row(
                    children: [
                      Container(
                        height: 60.0,
                        width: 120.0,
                        padding: EdgeInsets.symmetric(
                            vertical: 17.0, horizontal: 25.0),
                        child: Text('scan_label',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontFamily: 'Helve',
                                    fontWeight: FontWeight.bold))
                            .tr(),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(95.0),
                                topLeft: Radius.circular(95.0),
                                bottomRight: Radius.circular(200.0))),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.qr_code,
                          size: 30.0,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: kPrimaryColor,
                  size: 50,
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 300.0),
                  child: Text('scan_note',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black54,
                              fontFamily: 'Helve',
                              fontWeight: FontWeight.bold))
                      .tr(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String text) {
  Widget okButton = FlatButton(
    child: Text(
      'ok_button',
      style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor),
    ).tr(),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text(
      'note_label',
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: kPrimaryColor),
    ).tr(),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
