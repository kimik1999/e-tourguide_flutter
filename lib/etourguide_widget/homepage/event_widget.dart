import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etouguide_view/details_page_view.dart';
import 'package:flutter_etourguide/etourguide_model/event_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class EventWidget extends StatefulWidget {
  String type;
  EventWidget({this.type});
  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  void didUpdateWidget(covariant EventWidget oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ListEventViewModel>(context, listen: false).getCurrentEvent();
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ListEventViewModel>(context, listen: false).getCurrentEvent();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var listEventModel = Provider.of<ListEventViewModel>(context);
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 5, 0, 0),
          child: Text(
            'current_event_label',
            style: TextStyle(
                color: Colors.black.withOpacity(0.65),
                fontSize: 20,
                fontFamily: "Helve",
                fontWeight: FontWeight.normal),
          ).tr(),
        ),
        Container(
          margin: EdgeInsets.only(right: 14),
          height: 380,
          color: Colors.white,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listEventModel.events.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return new DetailsPageView(
                        event: new Event(
                          id: listEventModel.events[index].id,
                          name: widget.type != null
                              ? listEventModel.events[index].name_en
                              : listEventModel.events[index].name,
                          avgRating: listEventModel.events[index].rating,
                          imageUrl: listEventModel.events[index].imageUrl,
                          startDate: listEventModel.events[index].startedDate,
                          endDate: listEventModel.events[index].endDate,
                          description: widget.type != null
                              ? listEventModel.events[index].description_en
                              : listEventModel.events[index].description,
                          totalFeedback:
                              listEventModel.events[index].totalFeedback,
                        ),
                        type: widget.type,
                      );
                    },
                    settings: RouteSettings(name: "DetailsPageView")
                    ),
                    );
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(14, 14, 7, 14),
                        width: 270,
                        decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[300],
                                  offset: Offset(1.5, 3),
                                  spreadRadius: 1.5,
                                  blurRadius: 3)
                            ],
                            image: DecorationImage(
                                image: NetworkImage(listEventModel
                                        .events[index].imageUrl.isNotEmpty
                                    ? listEventModel.events[index].imageUrl
                                    : "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8184.jpg?size=626&ext=jpg"),
                                fit: BoxFit.cover)),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.black.withOpacity(0.15)),
                            ),
                            Positioned(
                                left: 10,
                                top: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100)),
                                      color: kPrimaryColor),
                                  child: Icon(
                                    Icons.stars_sharp,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  constraints: BoxConstraints(maxWidth: 250),
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.fromLTRB(14, 14, 0, 0),
                                  child: Text(
                                    'all_event_label',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: "Helve",
                                        fontWeight: FontWeight.bold),
                                  ).tr(),
                                ),
                                Container(
                                  constraints: BoxConstraints(maxWidth: 250),
                                  margin: EdgeInsets.only(left: 10, bottom: 15),
                                  padding: EdgeInsets.fromLTRB(14, 14, 0, 0),
                                  child: Text(
                                    widget.type != null
                                        ? listEventModel
                                                    .events[index].name_en !=
                                                null
                                            ? listEventModel
                                                .events[index].name_en
                                            : "Updating"
                                        : listEventModel.events[index].name,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.95),
                                      fontSize: 18,
                                      fontFamily: "Helve",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
