import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_vm_api.dart';
import 'package:flutter_etourguide/etourguide_widget/durationpage/duration_widget.dart';
import 'package:flutter_etourguide/etourguide_widget/durationpage/timepicker_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class TourDurationPageView extends StatefulWidget {
  String type;
  int index_setting;
  String time;
  TourDurationPageView({this.index_setting, this.time, this.type});
  @override
  _TourDurationPageViewState createState() => _TourDurationPageViewState();
}

class _TourDurationPageViewState extends State<TourDurationPageView>
    with AutomaticKeepAliveClientMixin<TourDurationPageView> {
  int selectedIndex = 0;
  String selectedTime = null;
  int count = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListExhibitViewModel()),
        ChangeNotifierProvider(create: (_) => RouteVMApi()),
      ],
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: menu(),
//        appBar: AppBar(
//          bottom: menu(),
//        ),
          //bottomNavigationBar: menu(),
        ),
      ),
    );
  }

  Widget menu() {
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text(
                'duration_label',
                style: TextStyle(
                    color: Colors.black45,
                    fontFamily: 'Helve',
                    fontSize: 21,
                    fontWeight: FontWeight.bold),
              ).tr(),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 15),
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: kPrimaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: Colors.white,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                  color: kPrimaryColor,
                ),
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                    //print(selectedIndex);
                  });
                },
                tabs: [
                  Tab(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('duration_30_tab').tr()),
                  ),
                  Tab(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('duration_60_tab').tr()),
                  ),
                  Tab(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('duration_cus_tab').tr()),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                      color: Colors.white,
                      child: DurationWidget(
                        time: "00:30:00",
                        type: widget.type,
                      )),
                  Container(
                      color: Colors.white,
                      child: DurationWidget(
                        time: "01:00:00",
                        type: widget.type,
                      )),
                  Container(
                      color: Colors.white,
                      child: TimePickerWidget(
                        type: widget.type,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //split"." to remove .0000 and padleft 8chars
  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");
}
