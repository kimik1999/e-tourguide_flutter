import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_etourguide/etourguide_model/exhibit_model.dart';
import 'package:flutter_etourguide/etourguide_model/route_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_vm_api.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ExhibitDetailsPageView extends StatefulWidget {
  Exhibit exhibit;
  String type;
  ExhibitDetailsPageView({this.exhibit, this.type});
  @override
  _ExhibitDetailsPageViewState createState() => _ExhibitDetailsPageViewState();
}

class _ExhibitDetailsPageViewState extends State<ExhibitDetailsPageView> {
  bool showDescription = false;
  List<String> exhibitId = [];
  @override
  void initState() {
    exhibitId.add(widget.exhibit.id.toString());
    //print(exhibitId.length);
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context != null)
        Provider.of<RouteVMApi>(context, listen: false)
            .getRouteByExhibit(exhibitId);
    });
    super.initState();
  }

//  @override
//  void dispose() {
//    SystemChrome.setEnabledSystemUIOverlays(
//        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    var routeViewModel = Provider.of<RouteVMApi>(context);
    return Scaffold(
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
                      color: Color(0xFF008a82),
                      blurRadius: 3,
                      offset: Offset(0, 2))
                ]),
            height: 40,
            width: MediaQuery.of(context).size.width * 0.5,
            child: RaisedButton.icon(
              label: Text('view_map',
                      style: TextStyle(
                          fontFamily: 'Helve',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold))
                  .tr(),
              icon: Icon(
                IconData(0xf5a0, fontFamily: 'IconCustom'),
                color: Colors.white.withOpacity(0.8),
                size: 14,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/BottomNavMap', (Route<dynamic> route) => false,
                    arguments: RouteViewModel(
                        route: RouteModel(
                            type: widget.type,
                            text: widget.type != null
                                ? routeViewModel.route[0].textRouteEng
                                : routeViewModel.route[0].textRouteVi,
                            listRoute: routeViewModel.route[0].listRoute)));
              },
              //color: Color(0xFF76c6bd),
              color: Color(0xFF008a82),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
            ),
            Container(
              //alignment: AlignmentDirectional.topStart,
              height: MediaQuery.of(context).size.height * 0.63,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(widget.exhibit.imageUrl),
                fit: BoxFit.cover,
              )),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 12, top: 12),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white.withOpacity(0.8),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.4,
                maxChildSize: 0.5,
                builder: (BuildContext context, scrollController) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              blurRadius: 5,
                              spreadRadius: 3,
                              offset: Offset(0, 2))
                        ]),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.006,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                                color: Color(0xFF008a82),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            widget.exhibit.name,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontFamily: 'Helve',
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 15),
                            child: Text('description',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontFamily: 'Helve',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))
                                .tr()),
                        Container(
                            padding: EdgeInsets.only(top: 10, right: 10),
                            child: Text(widget.exhibit.description,
                                maxLines: showDescription == true ? null : 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Helve',
                                  fontSize: 14,
                                ))),
                        Container(
                            padding: EdgeInsets.only(top: 5),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  showDescription = !showDescription;
                                });
                              },
                              child: Text(
                                  showDescription == true
                                      ? "show_shorten".tr()
                                      : "read_more".tr(),
                                  style: TextStyle(
                                      color: Color(0xFF008a82),
                                      fontFamily: 'Helve',
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold)),
                              //WidgetSpan(child: Icon(showDescription == true ? Icons.short_text: Icons.textsms_outlined, size: 15, color: Colors.black26,))
                            ))
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
