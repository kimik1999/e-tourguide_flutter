import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etouguide_view/exhibit_details_page_view.dart';
import 'package:flutter_etourguide/etourguide_model/exhibit_model.dart';
import 'package:flutter_etourguide/etourguide_model/route_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_vm_api.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class DurationWidget extends StatefulWidget {
  String time;
  String type;
  DurationWidget({this.time, this.type});
  @override
  _DurationWidgetState createState() => _DurationWidgetState();
}

class _DurationWidgetState extends State<DurationWidget> {
  @override
  void didUpdateWidget(covariant DurationWidget oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context != null)
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getExhibitInduration(widget.time);
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context != null)
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getExhibitInduration(widget.time);
    });
    //getBoolValue(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listExhibit = Provider.of<ListExhibitViewModel>(context);
    List<RouteModel> routeModel = [];
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return listExhibit.loadingStatus.toString().contains("completed")
        ? Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: Container(
              //padding: EdgeInsets.only(bottom: 30),
              height: 80,
              color: Colors.white,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: kPrimaryColor,
                            blurRadius: 3,
                            offset: Offset(0, 2))
                      ]),
                  height: 40,
                  width: 170,
                  child: RaisedButton.icon(
                    label: Text('start_label',
                            style: TextStyle(
                                fontFamily: 'Helve',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold))
                        .tr(),
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white.withOpacity(0.8),
                      size: 14,
                    ),
                    onPressed: () {
                      List<String> exhibitId = [];
                      exhibitId.clear();
                      for (int i = 0; i < listExhibit.exhibits.length; i++) {
                        if (listExhibit.exhibits[i].isChecked == true)
                          exhibitId.add(listExhibit.exhibits[i].id.toString());
                      }
                      if (exhibitId.length == 0) {
                        for (int i = 0; i < listExhibit.exhibits.length; i++) {
                          exhibitId.add(listExhibit.exhibits[i].id.toString());
                        }
                      } else {}
                      Provider.of<RouteVMApi>(context, listen: false)
                          .getListByExhibit(exhibitId)
                          .then((value) {
                        setState(() {
                          routeModel = value;
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/BottomNavMap', (Route<dynamic> route) => false,
                              arguments: RouteViewModel(
                                  route: RouteModel(
                                      type: widget.type,
                                      text: widget.type != null
                                          ? routeModel[0].textRouteEng
                                          : routeModel[0].textRouteVi,
                                      listRoute: routeModel[0].listRoute)));
                        });
                      });
                    },
                    //color: Color(0xFF76c6bd),
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            body: Container(
              color: Colors.white,
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.all(8.0),
                children: List.generate(listExhibit.exhibits.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MultiProvider(
                          providers: [
                            ChangeNotifierProvider(create: (_) => RouteVMApi())
                          ],
                          child: ExhibitDetailsPageView(
                            exhibit: new Exhibit(
                                id: listExhibit.exhibits[index].id,
                                name: widget.type != null
                                    ? listExhibit.exhibits[index].name_en
                                    : listExhibit.exhibits[index].name,
                                avgRating: listExhibit.exhibits[index].rating,
                                imageUrl: listExhibit.exhibits[index].imageUrl,
                                description: widget.type != null
                                    ? listExhibit.exhibits[index].description_en
                                    : listExhibit.exhibits[index].description,
                                totalFeedback:
                                    listExhibit.exhibits[index].totalFeedback),
                            type: widget.type,
                          ),
                        );
                      }));
                    },
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            image: DecorationImage(
                                image: listExhibit.exhibits[index].imageUrl !=
                                        null
                                    ? NetworkImage(
                                        listExhibit.exhibits[index].imageUrl)
                                    : NetworkImage(
                                        "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8184.jpg?size=626&ext=jpg"),
                                fit: BoxFit.fill),
                          ),
                        ),
                        widget.time.contains("0:00:00")
                            ? Theme(
                                data: ThemeData(
                                    unselectedWidgetColor: Colors.white),
                                child: Positioned(
                                  top: 15,
                                  left: 15,
                                  width: 15,
                                  height: 15,
                                  child: Checkbox(
                                      activeColor: Colors.black,
                                      value:
                                          listExhibit.exhibits[index].isChecked,
                                      onChanged: (isCheckedItem) {
                                        setState(() {
                                          listExhibit.exhibits[index]
                                              .isChecked = isCheckedItem;
                                        });
                                      }),
                                ),
                              )
                            : Container(),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              color: Colors.black.withOpacity(0.5)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 50),
                          child: Center(
                            child: Text(
                              widget.type != null
                                  ? listExhibit.exhibits[index].name_en
                                  : listExhibit.exhibits[index].name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Helve',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ),
          )
        : listExhibit.loadingStatus.toString().contains("searching")
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: LoadingBouncingGrid(
                  inverted: true,
                  shape: BoxShape.rectangle,
                  color: kPrimaryColor,
                  size: 25,
                  duration: Duration(milliseconds: 1200),
                ),
              )
            : Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: Center(
                    child: Text(
                  'duration_null',
                  style: TextStyle(
                      fontFamily: 'Helve',
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ).tr()),
              );
  }
}
