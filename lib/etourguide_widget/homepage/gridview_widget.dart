import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etouguide_view/exhibit_details_page_view.dart';
import 'package:flutter_etourguide/etourguide_model/event_model.dart';
import 'package:flutter_etourguide/etourguide_model/exhibit_model.dart';
import 'package:flutter_etourguide/etourguide_model/route_model.dart';
import 'package:flutter_etourguide/etourguide_model/topic_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_topic_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_vm_api.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class GridViewWidget extends StatefulWidget {
  int eventId;
  int topicId;
  Event event;
  Topic topic;
  String type;
  GridViewWidget({this.eventId, this.event, this.topicId, this.topic, this.type});

  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  bool isCheckedAll = false;
  bool isChekedItem = false;
  int count = 0;
  List<String> exhibitId = [];
  String test = "00:00:00";

  @override
  void didUpdateWidget(covariant GridViewWidget oldWidget) {
//    WidgetsBinding.instance.addPostFrameCallback((_){
//      if(context != null){
//        Provider.of<RouteVMApi>(context, listen: false)
//            .getRouteByExhibit(exhibitId);
//      }
//
//    });
  }
  @override
  void initState() {
    exhibitId = [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.eventId != null) {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getExhibitInEvent(widget.eventId);
        if (exhibitId.length > 0)
          Provider.of<ListEventViewModel>(context, listen: false)
              .getEventInDuration(widget.eventId.toString(), exhibitId)
              .toString();
      } else {
        Provider.of<ListExhibitViewModel>(context, listen: false)
            .getExhibitInTopic(widget.topicId);
        if (exhibitId.length > 0) {
          Provider.of<ListTopicViewModel>(context, listen: false)
              .getTopicInDuration(widget.topicId.toString(), exhibitId)
              .toString();
        }
      }
//      if(context != null){
//        Provider.of<RouteVMApi>(context, listen: false)
//            .getRouteByExhibit(exhibitId);
//      }
    });
    //getBoolValue(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listExhibit = Provider.of<ListExhibitViewModel>(context);
    var duration = Provider.of<ListEventViewModel>(context);
    List<RouteModel> routeModel = [];
    //var listExhibit = Provider.of<ListExhibitViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'choose_exhibit_label',
              style: TextStyle(
                color: Colors.black45,
                fontFamily: 'Helve',
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.black45),
              child: Checkbox(
                  value: isCheckedAll,
                  activeColor: Colors.black,
                  onChanged: (bool value) {
                    setState(() {
                      exhibitId.clear();
                      listExhibit.exhibits.forEach((index) {
                        index.isChecked = value;
                        if (index.isChecked == true) {
                          exhibitId.add(index.id.toString());
                        } else {
                          exhibitId.clear();
                        }
                      });
                      isChekedItem = value;
                      //print(isChekedItem);
                      isCheckedAll = value;
                      if (isCheckedAll == true) {
                        if (widget.eventId != null) {
                          //print(widget.eventId);
                          Provider.of<ListEventViewModel>(context,
                                  listen: false)
                              .getEventInDuration(
                                  widget.eventId.toString(), exhibitId)
                              .then((String result) {
                            setState(() {
                              //print(result);
                              test = result;
                            });
                          });
                        } else {
                          Provider.of<ListTopicViewModel>(context,
                                  listen: false)
                              .getTopicInDuration(
                                  widget.topicId.toString(), exhibitId)
                              .then((String result) {
                            setState(() {
                              //print(result);
                              test = result;
                            });
                          });
                        }
                        // duration = Provider.of<ListEventViewModel>(context, listen: false);
                      } else {
                        test = '00:00:00';
                      }
                      ;
                      //print(test);
                    });
                  }),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black45),
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: Offset(0, 2))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      //color: kPrimaryColor
                    ),
                    child: Text(
                      test != null
                          ? "est_label".tr() + test
                          : "est_label 00:00:00".tr(),
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: 'Helve',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                                color: kPrimaryColor,
                                blurRadius: 4,
                                offset: Offset(0, 2))
                          ]),
                      height: 50,
                      width: 140,
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
                          if (exhibitId.length > 0) {
                            Provider.of<RouteVMApi>(context, listen: false)
                                .getListByExhibit(exhibitId)
                                .then((value) {
                              setState(() {
                                routeModel = value;
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/BottomNavMap',
                                    (Route<dynamic> route) => false,
                                    arguments: RouteViewModel(
                                        route: RouteModel(
                                            event: widget.event != null ? widget.event : null,
                                            topic: widget.topic != null ? widget.topic : null,
                                            type: widget.type,
                                            text: widget.type != null
                                                ? routeModel[0].textRouteEng
                                                : routeModel[0].textRouteVi,
                                            listRoute:
                                                routeModel[0].listRoute)));
                              });
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 200,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            "assets/images/mtgsystem_logo.png",
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
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
                                            'note_text',
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
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ).tr(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ), //this right here
                                  );
                                });
                          }
                        },
                        //color: Color(0xFF76c6bd),
                        color: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        //child: Text("View Direction",
                        // style: TextStyle(fontFamily: 'CourNew', color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: GridView.count(
          crossAxisCount: 3,
          padding: EdgeInsets.all(8.0),
          children: List.generate(listExhibit.exhibits.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
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
                  Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                              image: NetworkImage(
                                  listExhibit.exhibits[index].imageUrl),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(
                          value: listExhibit.exhibits[index].isChecked,
                          activeColor: Colors.black,
                          onChanged: (isCheckedItem) {
                            //print('ontap ${isChekedItem}');
                            // print(value);
                            setState(() {
                              listExhibit.exhibits[index].isChecked =
                                  isCheckedItem;
                              if (isChekedItem) {
                                count = 0;
                                //print(isChekedItem);
                                listExhibit.exhibits.forEach((index) {
                                  if (index.isChecked) {
                                    if (count < listExhibit.exhibits.length) {
                                      count = count + 1;
                                      //exhibitId.add(index.id.toString());
                                    } //count total = list.length
                                  } else {
                                    exhibitId.remove(index.id.toString());
                                  }
                                });
                                if (0 <= count &&
                                    count < listExhibit.exhibits.length) {
                                  // print('count false: ${count}');
                                  isCheckedAll = false;
                                } else {
                                  // print('count true: ${count}');
                                  isCheckedAll = true;
                                }
                                if (exhibitId.isNotEmpty) {
                                  if (widget.eventId != null) {
                                    Provider.of<ListEventViewModel>(context,
                                            listen: false)
                                        .getEventInDuration(
                                            widget.eventId.toString(),
                                            exhibitId)
                                        .then((String result) {
                                      setState(() {
                                        //print(result);

                                        test = result;
                                      });
                                    });
                                  } else {
                                    Provider.of<ListTopicViewModel>(context,
                                            listen: false)
                                        .getTopicInDuration(
                                            widget.topicId.toString(),
                                            exhibitId)
                                        .then((String result) {
                                      setState(() {
                                        //print(result);
                                        test = result;
                                      });
                                    });
                                  }
                                } else {
                                  test = "00:00:00";
                                }
                              } else {
                                //print("ahihi");
                                exhibitId.clear();
                                count = 0;
                                //print('TH22 ${count}');
                                listExhibit.exhibits.forEach((index) {
                                  if (index.isChecked) {
                                    exhibitId.add(index.id.toString());
                                    //print(exhibitId.length);
                                    if (count < listExhibit.exhibits.length) {
                                      count = count + 1;
                                      //print('id ${index.id.toString()}');
                                    } //count total = list.length
                                  } else {
                                    exhibitId.remove(index.id.toString());
                                  }
                                });
                                //print(exhibitId.length);
                                //print('TH22 ${count}');
                                if (count == listExhibit.exhibits.length) {
                                  isCheckedAll = true;
                                } else {
                                  isCheckedAll = false;
                                }
                                if (exhibitId.isNotEmpty) {
                                  if (widget.eventId != null) {
                                    Provider.of<ListEventViewModel>(context,
                                            listen: false)
                                        .getEventInDuration(
                                            widget.eventId.toString(),
                                            exhibitId)
                                        .then((String result) {
                                      setState(() {
                                        //print(result);

                                        test = result;
                                      });
                                    });
                                  } else {
                                    Provider.of<ListTopicViewModel>(context,
                                            listen: false)
                                        .getTopicInDuration(
                                            widget.topicId.toString(),
                                            exhibitId)
                                        .then((String result) {
                                      setState(() {
                                        //print(result);
                                        test = result;
                                      });
                                    });
                                  }
                                } else {
                                  test = "00:00:00";
                                }
                              }
                            });
                          },
                        ),
                      )
                    ],
                  ),
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
    );
  }
}
