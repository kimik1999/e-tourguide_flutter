import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etourguide_widget/durationpage/duration_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class TimePickerWidget extends StatefulWidget {
  String type;
  TimePickerWidget({this.type});
  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  Duration duration = new Duration(minutes: 0);
  String time = null;
  @override
  void didUpdateWidget(covariant TimePickerWidget oldWidget) {
    //print("${time} update");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
  }

  //Duration duration;
//  String selectedIndex = 'Others';
//  List<String> item = ['Others', '90 min', '120 min', '150 min', '180 min'];
  @override
  Widget build(BuildContext context) {
    StateSetter _setStateWidget;
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        color: Colors.white,
        child: Stack(
          children: [
            time == null || time.contains("0000null")
                ? Container()
                : DurationWidget(
                    time: time,
                    type: widget.type,
                  ),
          ],
        ),
      ),
      floatingActionButton: Theme(
        data: ThemeData(
            primaryColor: kPrimaryColor,
            primaryColorLight: Colors.white,
            accentColor: kPrimaryColor),
        child: Builder(
            builder: (BuildContext context) => new FloatingActionButton(
                  backgroundColor: kPrimaryColor,
                  onPressed: () async {
                    Duration resultingDuration = await showDurationPicker(
                      snapToMins: 5,
                      context: context,
                      initialTime: new Duration(minutes: 30),
                    );
                    setState(() {
                      Duration max_duration =
                          new Duration(hours: 3, minutes: 0, seconds: 0);
                      //print(max_duration);
                      if (resultingDuration <= max_duration) {
                        time = resultingDuration
                            .toString()
                            .padLeft(8, "0")
                            .split('.')[0];
                      } else {
                        time = "0000null";
                        showMessageDialog();
                      }
                      print(time);
                    });
                  },
                  tooltip: 'Popup Duration Picker',
                  child: new Icon(Icons.access_time),
                )),
      ),
    );
  }

  void showMessageDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)), //this right here
            child: Container(
              alignment: Alignment.center,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/mtgsystem_logo.png",
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Text(
                    'note_label',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Helve",
                        color: kPrimaryColor,
                        fontSize: 17),
                  ).tr(),
                  Text(
                    'duration_mes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Helve",
                        color: Colors.black45,
                        fontSize: 14),
                  ).tr(),
                  Container(
                    alignment: Alignment.center,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: kPrimaryColor,
                      child: Text(
                        'ok_button',
                        style: TextStyle(color: Colors.white),
                      ).tr(),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
