
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_model/icon_room_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/floorplan_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_widget/homepage/exhibit_widget.dart';
import 'package:provider/provider.dart';

class IconRoomWidget extends StatefulWidget {
  int floor;
  int roomId;
  IconRoomWidget({this.floor, this.roomId});
  @override
  _IconRoomWidgetState createState() => _IconRoomWidgetState();
}

class _IconRoomWidgetState extends State<IconRoomWidget> {
  @override
  void didUpdateWidget(covariant IconRoomWidget oldWidget) {
    widget.floor == 1 && widget.roomId != 0 ? Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: ExhibitWidget(180, 110, roomId: widget.roomId,),
    ) : Container();
    super.didUpdateWidget(oldWidget);
  }
  @override
  Widget build(BuildContext context) {
    //int roomId = 0;
    final Size size = MediaQuery.of(context).size;
        return Column(
          //crossAxisAlignment: CrossAxisAlignment.end,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: Image.asset(
                      'assets/images/museum_floor${widget.floor}.png',
                    ),
                  ),
                  CustomPaint(
                    size: MediaQuery.of(context).size,
                    painter: ShapePainter(context: this.context),
                  ),
                  Transform.translate(
                    offset: Offset(
                      size.width * 0.1,
                      size.width * 0.008,
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.center,
                      child: Container(
                        height: 10,
                        width: 10,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: Colors.white,
                          //color: floor == 2 ? Colors.orangeAccent[200] : null,
                          onPressed: (){
                            widget.roomId = 1;
//                            setState(() {
//                              roomId = 1;
//                            });
                          },
                          child: Text(
                            "1",
                            style: TextStyle(
                                fontFamily: 'CourNew',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 6
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                      size.width * 0.1,
                      size.width * 0.065,
                    ),
                    child: Stack(
                        children: [Align(
                          alignment: AlignmentDirectional.center,
                          child: Container(
                            height: 10,
                            width: 10,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              color: Colors.white,
                              //color: floor == 2 ? Colors.orangeAccent[200] : null,
                              onPressed: (){
                                widget.roomId = 2;
//                                setState(() {
//                                  roomId = 2;
//                                });
                              },
                              child: Text(
                                "2",
                                style: TextStyle(
                                    fontFamily: 'CourNew',
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 6
                                ),
                              ),
                            ),
                          ),
                        ),
                        ]),
                  ),
                ],

              ),
            ),
          ],
        );
  }
}
class ShapePainter extends CustomPainter{
  BuildContext context;
  ShapePainter({this.context});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final Size size = MediaQuery.of(context).size;
    List<Offset> list = [];
    Offset n1 = Offset(size.width * 0.5001, size.height * 0.532);
    list.add(n1);
    Offset n2 = Offset(size.width * 0.5001, size.height * 0.4805);
    list.add(n2);
    Offset n3 = Offset(size.width * 0.611, size.height * 0.4805);
    list.add(n3);

    canvas.drawLine(n1, n2, paint);
    canvas.drawLine(n3, n2, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

