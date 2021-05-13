import 'package:flutter/material.dart';
import 'package:flutter_etourguide/constraint.dart';
import 'package:flutter_etourguide/etouguide_view/details_page_view.dart';
import 'package:flutter_etourguide/etouguide_view/exhibit_details_page_view.dart';
import 'package:flutter_etourguide/etourguide_model/event_model.dart';
import 'package:flutter_etourguide/etourguide_model/exhibit_model.dart';
import 'package:flutter_etourguide/etourguide_model/topic_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_vm_api.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:easy_localization/easy_localization.dart';

class CarouselConstructor extends StatelessWidget {
  String tab_name;
  int id;
  String type;
  String imgUrl;
  String startDate;
  String endDate;
  String description;
  String name;
  double rating;
  int totalFeedback;
  CarouselConstructor(
      {this.tab_name,
      this.id,
      this.imgUrl,
      this.type,
      this.name,
      this.rating,
      this.startDate,
      this.endDate,
      this.description,
      this.totalFeedback});
  @override
  Widget build(BuildContext context) {
    if (type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return Builder(
      builder: (BuildContext context) {
        return Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            GestureDetector(
              onTap: () {
                tab_name != null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) {
                              if (tab_name != null) {
                                if (tab_name.contains("event")) {
                                  return DetailsPageView(
                                    event: new Event(
                                      id: id,
                                      name: name,
                                      avgRating: rating,
                                      imageUrl: imgUrl,
                                      startDate:
                                          startDate != null ? startDate : "",
                                      endDate: endDate != null ? endDate : "",
                                      description: description,
                                      totalFeedback: totalFeedback,
                                    ),
                                    type: type,
                                  );
                                } else if (tab_name.contains("topic")) {
                                  return DetailsPageView(
                                    topic: new Topic(
                                        id: id,
                                        name: name,
                                        avgRating: rating,
                                        imageUrl: imgUrl,
                                        startDate:
                                            startDate != null ? startDate : "",
                                        description: description,
                                        totalFeedback: totalFeedback),
                                    type: type,
                                  );
                                } else {
                                  return MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider(
                                          create: (_) => RouteVMApi())
                                    ],
                                    child: ExhibitDetailsPageView(
                                      exhibit: new Exhibit(
                                        id: id,
                                        name: name,
                                        avgRating: rating,
                                        imageUrl: imgUrl,
                                        description: description,
                                        totalFeedback: totalFeedback,
                                      ),
                                      type: type,
                                    ),
                                  );
                                }
                              } else {}
                            },
                            settings: RouteSettings(name: "DetailsPageView")))
                    : "";
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      imgUrl != null && imgUrl.contains("http")
                          ? imgUrl
                          : "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8184.jpg?size=626&ext=jpg",
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(25, 20, 20, 10),
                  child: Text(
                    name != null ? name : "",
                    style: TextStyle(
                        fontFamily: 'Helve',
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(25, 0, 20, 20),
                  child: rating != 0 && !tab_name.contains("exhibit")
                      ? SmoothStarRating(
                          starCount: 5,
                          size: 14,
                          color: kPrimaryColor,
                          borderColor: kPrimaryColor,
                          rating: rating != null ? rating : 0,
                          isReadOnly: true,
                          allowHalfRating: true,
                          spacing: 1,
                        )
                      : null,
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
