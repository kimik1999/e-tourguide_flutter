import 'dart:math' as math;
import 'package:arrow_path/arrow_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etourguide_model/icon_room_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/icon_room_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_icon_room_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/map_upload_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/map_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_widget/homepage/exhibit_widget.dart';
import 'package:flutter_etourguide/etourguide_widget/mappage/tab_feedback_map.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

class MapPageView extends StatefulWidget {
  String type;
  MapPageView({this.type});
  @override
  _MapPageViewState createState() => _MapPageViewState();
}

class _MapPageViewState extends State<MapPageView>
    with AutomaticKeepAliveClientMixin<MapPageView> {
  double aspect;
  bool hasTouch = false;
  int floor = 1;
  int roomId = 0;
  String mapUrl = "";
  List<IconRoom> listButton = [];
  @override
  bool get wantKeepAlive => true;
  String stairs = "ST";
  String start = "S";
  @override
  void didUpdateWidget(covariant MapPageView oldWidget) {
    //print(floor);
    RouteViewModel args = ModalRoute.of(context).settings.arguments;
    roomId != 0
        ? Container(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ExhibitWidget(
              180,
              110,
              roomId: roomId,
              type: args != null ? args.type : widget.type,
            ),
          )
        : Container();

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MapUploadViewModel>(context, listen: false)
          .getMap(floor)
          .then((value) {
        setState(() {
          mapUrl = value;
        });
      });
      Provider.of<MapUploadViewModel>(context, listen: false).getAllPosition();
      Provider.of<ListIconRoomViewModel>(context, listen: false)
          .getIconRoomButton(floor)
          .then((value) {
        setState(() {
          listButton = value;
          //print(listButton.length);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RouteViewModel args = ModalRoute.of(context).settings.arguments;
    //args # null when call Map route
    if (args != null) {
      if (args.type != null) {
        context.locale = Locale('en', 'US');
      } else {
        context.locale = Locale('vi', 'VN');
        widget.type = null;
      }
      if (args.scan != null && int.parse(args.scan) > 0) {
        //print(args.scan.toString());
        roomId = int.parse(args.scan);
        floor = args.floor;
      }
    } else {
      //not call Map route, be like: widget.type = args.type
      if (widget.type != null) {
        context.locale = Locale('en', 'US');
      } else {
        context.locale = Locale('vi', 'VN');
      }
    }
    var listPosition = Provider.of<MapUploadViewModel>(context);

    IconRoomViewModel model = new IconRoomViewModel();
    //print(model.listIconFloor1.length);
    final Size size = MediaQuery.of(context).size;
    //final model = Provider.of<FloorPlanViewModel>(context);
    // List<IconRoom> tileLights = model.iconRooms.toList();
    if ((size.width / size.height) > 1.76) {
      aspect = 16 / 9;
    } else if ((size.width / size.height) < 1.77 &&
        (size.width / size.height) >= 1.6) {
      aspect = 16 / 10;
    } else {
      aspect = 4 / 3;
    }
    return Provider.of<MapUploadViewModel>(context, listen: false)
                .loadingStatus
                .toString()
                .contains("completed") &&
            Provider.of<ListIconRoomViewModel>(context, listen: false)
                .loadingStatus
                .toString()
                .contains("completed")
        ? GestureDetector(
            onTap: () {
              setState(() {
                hasTouch = true;
              });
              //print(hasTouch);
            },
            child: LayoutBuilder(builder: (context, constraint) {
              return AspectRatio(
                aspectRatio: aspect,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: InteractiveViewer(
                          panEnabled:
                              true, // Set it to false to prevent panning.
                          //boundaryMargin: EdgeInsets.all(80),
                          minScale: 1,
                          maxScale: 2.5,
                          scaleEnabled: true,
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        color: Colors.white,
                                        child: mapUrl != null
                                            ? Image.network(mapUrl)
                                            : Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                color: Colors.white,
                                                child: LoadingBouncingGrid(
                                                  inverted: true,
                                                  shape: BoxShape.rectangle,
                                                  color: kPrimaryColor,
                                                  size: 25,
                                                  duration: Duration(
                                                      milliseconds: 1200),
                                                ),
                                              )),
                                    IgnorePointer(
                                      ignoring: true,
                                      child: CustomPaint(
                                        size: MediaQuery.of(context).size,
                                        painter: ShapePainter(
                                            context: this.context,
                                            listPosition: listPosition.maps,
                                            floor: args != null &&
                                                    args.scan != null
                                                ? args.floor
                                                : floor,
                                            input_route: args != null
                                                ? args.listRoute != null
                                                    ? args.listRoute
                                                    : null
                                                : null),
                                      ),
                                    ),
                                    Stack(
                                      children: List.generate(
                                        listButton.length,
                                        (i) {
                                          return Transform.translate(
                                            offset: Offset(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  listButton[i].dx,
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  listButton[i].dy,
                                            ),
                                            child: Stack(children: [
                                              Align(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                child: Container(
                                                  height: 10,
                                                  width: 10,
                                                  child: RaisedButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    color: roomId ==
                                                                listButton[i]
                                                                    .roomId &&
                                                            listButton[i]
                                                                    .roomId !=
                                                                0
                                                        ? kPrimaryColor
                                                        : Colors.white,

                                                    //color: floor == 2 ? Colors.orangeAccent[200] : null,
                                                    onPressed: () {
                                                      setState(() {
                                                        //print("${floor} in button");
//                                                print(model.listIconFloor1[i]
//                                                    .id);
                                                        if (args != null && args.scan != null)
                                                          args.scan = "0";
                                                        if (listButton[i]
                                                                .type ==
                                                            2) {
                                                          //print("th1");
                                                          //print(model.listIconFloor1[i].id);
                                                          roomId = listButton[i]
                                                              .roomId;

                                                          // print(roomId);
                                                        } else if (listButton[i]
                                                                .type ==
                                                            3) {
                                                          if (floor == 1) {
                                                            floor = 2;
                                                          } else {
                                                            floor = 1;
                                                          }
                                                          if (args != null &&
                                                              args.scan !=
                                                                  null) {
                                                            args.floor = floor;
                                                          }
                                                          Provider.of<MapUploadViewModel>(
                                                                  context,
                                                                  listen: false)
                                                              .getMap(floor)
                                                              .then((value) {
                                                            setState(() {
                                                              mapUrl = value;
                                                            });
                                                          });
                                                          Provider.of<ListIconRoomViewModel>(
                                                                  context,
                                                                  listen: false)
                                                              .getIconRoomButton(
                                                                  floor)
                                                              .then((value) {
                                                            setState(() {
                                                              listButton =
                                                                  value;
//                                                              print(listButton
//                                                                  .length);
                                                            });
                                                          });
                                                        } else {}
//                                                if(floor == 1 && model.listIconFloor1[i].id.toString().length == 3){
//                                                  floor = 2;
////                                                  if(args != null)
////                                                    args.scan = "0";
//                                                } else if(floor == 2 && model.listIconFloor2[i].id.toString().length == 3){
//                                                  floor = 1;
////                                                  if(args != null)
////                                                    args.scan = "0";
//                                                }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              IgnorePointer(
                                                ignoring: true,
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  child: Text(
                                                    listButton[i].type == 2
                                                        ? "${listButton[i].roomId.toString()}"
                                                        : listButton[i].type ==
                                                                3
                                                            ? "${stairs}"
                                                            : "${start}",
                                                    style: TextStyle(
                                                        fontFamily: 'Helve',
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 6),
                                                  ),
                                                ),
                                              )
                                            ]),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 5),
                                  child: Container(
                                    width: 60,
                                    height: 40,
                                    child: RaisedButton(
                                      onPressed: () {
                                        showAlertDialog(
                                            context,
                                            args != null
                                                ? args.text != null
                                                    ? args.text
                                                    : 'direction_data'.tr()
                                                : 'direction_data'.tr());
                                      },
                                      child: Icon(
                                        Icons.map,
                                        color: kPrimaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, bottom: 5),
                                  child: Container(
//                      bottom: MediaQuery.of(context).size.width * 0.62,
//                      right: 10,
                                    width: 40,
                                    height: 40,
                                    child: RaisedButton(
                                      color: floor == 2 ? kPrimaryColor : null,
                                      onPressed: () {
                                        setState(() {
                                          floor = 2;
                                          if (args != null &&
                                              args.scan != null) {
                                            args.floor = floor;
                                          }
                                          Provider.of<MapUploadViewModel>(
                                                  context,
                                                  listen: false)
                                              .getMap(floor)
                                              .then((value) {
                                            setState(() {
                                              mapUrl = value;
                                            });
                                          });
                                          Provider.of<ListIconRoomViewModel>(
                                                  context,
                                                  listen: false)
                                              .getIconRoomButton(floor)
                                              .then((value) {
                                            setState(() {
                                              listButton = value;
                                            });
                                          });
                                        });
                                      },
                                      child: Text(
                                        "2",
                                        style: TextStyle(
                                            fontFamily: 'Helve',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 5),
                                  child: Container(
                                    width: 100,
                                    height: 40,
                                    child: RaisedButton(
                                        onPressed: () {
                                          showListFeedbackDialog();
                                        },
                                        child: Text(
                                          'review',
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ).tr()),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, bottom: 15),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    child: RaisedButton(
                                      color: floor == 1 ? kPrimaryColor : null,
                                      onPressed: () {
                                        setState(() {
                                          floor = 1;
                                          if (args != null &&
                                              args.scan != null) {
                                            args.floor = floor;
                                          }
                                          Provider.of<MapUploadViewModel>(
                                                  context,
                                                  listen: false)
                                              .getMap(floor)
                                              .then((value) {
                                            setState(() {
                                              mapUrl = value;
                                            });
                                          });
                                          Provider.of<ListIconRoomViewModel>(
                                                  context,
                                                  listen: false)
                                              .getIconRoomButton(floor)
                                              .then((value) {
                                            setState(() {
                                              listButton = value;
                                            });
                                          });
                                        });
                                      },
                                      child: Text(
                                        "1",
                                        style: TextStyle(
                                            fontFamily: 'Helve',
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            roomId != 0
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    child: ExhibitWidget(
                                      MediaQuery.of(context).size.height * 0.4,
                                      MediaQuery.of(context).size.width * 0.28,
                                      roomId: roomId,
                                      type: args != null
                                          ? args.type
                                          : widget.type,
                                    ),
                                  )
                                : Container()
//                    Expanded(child:
//                    floor == 1 && roomId != 0 ? Container(
//                      height: MediaQuery.of(context).size.height * 0.25,
//                      child: ExhibitWidget(180, 110, roomId: roomId,),
//                    ) : Container())
                          ],
                        ),
                      ),

//              hasTouch ? Container(height: 0, width: 0,) : MapTouchWidget(),
//                Expanded(child:
//                floor == 1 && roomId != 0 ? Container(
//                  height: MediaQuery.of(context).size.height * 0.25,
//                  child: ExhibitWidget(180, 110, roomId: roomId,),
//                ) : Container()
//                )
                    ],
                  ),
                ),
              );
            }),
          )
        : Container(
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
          );
  }

//   Widget callMapTouchWidget(bool hasTouch){
//     setState(() {
//       hasTouch = true;
//     });
//     MapTouchWidget();
//   }
  void showListFeedbackDialog() async {
    await showDialog(
        context: this.context,
        builder: (BuildContext context) {
          RouteViewModel args = ModalRoute.of(context).settings.arguments;
          return SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15.0)), //this right here
                    child: TabFeedbackMap(
                      type: args != null ? args.type : widget.type,
                      topic: args != null && args.topic != null ? args.topic : null,
                      event:  args != null && args.event != null ? args.event : null,
                    ),
                  )));
        });
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

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      'direction_dialog_label',
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: kPrimaryColor),
    ).tr(),
    content: SingleChildScrollView(child: Text(text)),
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

class ShapePainter extends CustomPainter {
  BuildContext context;
  int floor;
  List<MapsViewModel> listPosition;
  List<dynamic> input_route;
  ShapePainter({this.context, this.floor, this.input_route, this.listPosition});
  @override
  void paint(Canvas canvas, Size size) {
    Path path;
    var paint = Paint()
      ..color = kPrimaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
//    print(floor);
//    print(listPosition.length);
//    print(input_route);
    final Size size = MediaQuery.of(context).size;
    //print("${listPosition.length} list custom");
    List<Offset> list = [];
    list.add(null);
    if (listPosition.length > 0) {
      for (int i = 0; i < listPosition.length; i++) {
        list.add(Offset(
            size.width * listPosition[i].dx, size.height * listPosition[i].dy));
      }
      path = Path();
      if (input_route != null) {
        path.moveTo(list[input_route[0]].dx, list[input_route[0]].dy);
        for (int i = 0; i < input_route.length - 1; i++) {
          if (floor == 1 && input_route[i] <= 40) {
            if (i == 0) {
              path.lineTo(
                  list[input_route[i + 1]].dx, list[input_route[i + 1]].dy);
              path = ArrowPath.make(
                  path: path, tipLength: 5, tipAngle: math.pi * 0.12);
              canvas.drawPath(path, paint);
              i = i + 1;

            }
            if (input_route[i - 1] == 41) {
              path.moveTo(list[29].dx, list[29].dy);
            }
            if (input_route[i - 1] == 50) {
              path.moveTo(list[30].dx, list[30].dy);
            }
            if (input_route[i + 1] > 40) {
              path.close();
            } else {
              path.lineTo(
                  list[input_route[i + 1]].dx, list[input_route[i + 1]].dy);
              path = ArrowPath.make(
                  path: path, tipLength: 5, tipAngle: math.pi * 0.12);
              canvas.drawPath(path, paint);
            }
          } else if (floor == 2 && input_route[i] > 40) {
            if (i == 0) {
              path.lineTo(
                  list[input_route[i + 1]].dx, list[input_route[i + 1]].dy);
              path = ArrowPath.make(
                  path: path, tipLength: 5, tipAngle: math.pi * 0.12);
              canvas.drawPath(path, paint);
              i = i + 1;
            }
            if (input_route[i - 1] == 29) {
              path.moveTo(list[41].dx, list[41].dy);
            }
            if (input_route[i - 1] == 30) {
              path.moveTo(list[50].dx, list[50].dy);
            }
            if (input_route[i + 1] <= 40) {
              path.close();
            } else {
              path.lineTo(
                  list[input_route[i + 1]].dx, list[input_route[i + 1]].dy);
              path = ArrowPath.make(
                  path: path, tipLength: 5, tipAngle: math.pi * 0.12);
              canvas.drawPath(path, paint);
            }
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
