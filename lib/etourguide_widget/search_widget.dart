import 'package:flutter/material.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/list_searchdata_viewmodel.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/search_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  String type;
  SearchWidget({this.type});
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  void didUpdateWidget(covariant SearchWidget oldWidget) {
//    WidgetsBinding.instance.addPostFrameCallback((_){
//      Provider.of<ListExhibitViewModel>(context, listen: false)
//          .getSuggestionExhibit();
//    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ListSearchDataViewModel>(context, listen: false)
          .getSuggestionSearch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type != null && widget.type.contains("en")) {
      context.locale = Locale('en', 'US');
    } else {
      context.locale = Locale('vi', 'VN');
    }
    var listExhibit = Provider.of<ListSearchDataViewModel>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 40, 18, 15),
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              maxLines: 1,
              onTap: () {
                showSearch(
                    context: context,
                    delegate: SearchViewModel(
                        type: widget.type, listExhibit: listExhibit.exhibits));
              },
              enableInteractiveSelection: false,
              onChanged: (text) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                  icon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(Icons.search, color: Colors.black26),
                  ),
                  hintText: 'search_hint_text'.tr(),
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0)),
            ),
          ),
        ],
      ),
    );
  }
}
