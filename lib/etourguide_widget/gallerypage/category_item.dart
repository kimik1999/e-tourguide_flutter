import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/gallery_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_event_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_searchdata_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_topic_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_etourguide/etourguide_widget/gallerypage/list_item_widget.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  String type;
  Category({this.type});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  GalleryViewModel galleryViewModel = new GalleryViewModel();
  @override
  Widget build(BuildContext context) {
    if (widget.type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.8,
      padding: EdgeInsets.only(left: 10, right: 10),
      shrinkWrap: true,
      primary: false,
      children: List.generate(galleryViewModel.ListGallery.length, (index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              // return Container();
              return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => ListTopicViewModel()),
                    ChangeNotifierProvider(create: (_) => ListEventViewModel()),
                    ChangeNotifierProvider(
                        create: (_) => ListExhibitViewModel()),
                    ChangeNotifierProvider(
                        create: (_) => ListSearchDataViewModel()),
                  ],
                  child: ListItemStf(
                    item_name: galleryViewModel.ListGallery[index].name,
                    type: widget.type,
                  ));
            }));
          },
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[300],
                        offset: Offset(1.5, 3),
                        spreadRadius: 1.5,
                        blurRadius: 3)
                  ],
                  color: Color(0xFF008a82),
//                  image: DecorationImage(
//                    image: NetworkImage(galleryViewModel.ListGallery[index].imageUrl,
//                    ),
//                    fit: BoxFit.cover,
//                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //textBaseline: TextBaseline.alphabetic,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Colors.white,
                        ),
                        child: Icon(
                          galleryViewModel.ListGallery[index].icon,
                          color: Color(0xFF008a82),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 60,
                        // color: Colors.white,
//                        decoration: BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(100)),
//                          color: Colors.white,
//                        ),
                        child: Text(
                          galleryViewModel.ListGallery[index].name
                                  .contains("Event")
                              ? 'all_event_label'
                              : galleryViewModel.ListGallery[index].name
                                      .contains("Topic")
                                  ? 'all_topic_label'
                                  : galleryViewModel.ListGallery[index].name
                                          .contains("Exhibit")
                                      ? 'all_exhibit_label'
                                      : "",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Helve',
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ).tr(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
