import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_model/exhibit_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/exhibit_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_searchdata_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_widget/gallerypage/list_item_widget.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchViewModel extends SearchDelegate<String> {
  String type;
  List<ExhibitViewModel> listExhibit;
  SearchViewModel({this.type, this.listExhibit});

  //List<String> suggestionList = ["Suggestion 1", "Suggestion 2", "Suggestion 3"];
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (type != null) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ListSearchDataViewModel())
        ],
        child: ListItemStf(
          item_name: "search",
          query: query,
          type: type,
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ExhibitViewModel> top10Suggest = [];
    int top_suggestion = 10;
    if(listExhibit.length > 0 && listExhibit.length >= top_suggestion){
      for (int i = 0; i < top_suggestion; i++) {
        top10Suggest.add(new ExhibitViewModel(
            exhibit: Exhibit(
                name: listExhibit[i].name, name_en: listExhibit[i].name_en)));
      }
      final suggestionList = query.isEmpty
          ? top10Suggest
          : listExhibit
          .where((element) => type != null
          ? element.name_en.toLowerCase().startsWith(query.toLowerCase())
          : element.name.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
      return ListView.builder(
          itemCount: suggestionList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                query = type != null
                    ? suggestionList[index].name_en
                    : suggestionList[index].name;
                showResults(context);
              },
              child: ListTile(
                title: Text(type != null
                    ? suggestionList[index].name_en
                    : suggestionList[index].name),
              ),
            );
          });
    } else {
      return Container();
    }
  }
}
