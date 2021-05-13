import 'package:flutter/cupertino.dart';
import 'package:flutter_etourguide/etourguide_model/route_model.dart';
import 'package:flutter_etourguide/etourguide_viewmodel/route_viewmodel.dart';
import 'package:flutter_etourguide/services/web_services.dart';

enum LoadingStatus { completed, searching, empty }

class RouteVMApi with ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<RouteViewModel> route = List<RouteViewModel>();

  void getRouteByExhibit(List<String> exhibitId) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<RouteModel> listRoute =
        await WebService().fetchRouteByExhibit(exhibitId);
    this.route =
        listRoute.map((route) => RouteViewModel(route: route)).toList();
    if (route == null) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }

  Future<List<RouteModel>> getListByExhibit(List<String> exhibitId) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<RouteModel> listRoute =
        await WebService().fetchRouteByExhibit(exhibitId);
    this.route =
        listRoute.map((route) => RouteViewModel(route: route)).toList();
    if (route == null) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
    return listRoute;
  }

  Future<List<RouteModel>> suggestBackToStartPoint(int roomId) async {
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    List<RouteModel> listRoute =
    await WebService().fetchRouteBackToStartPoint(roomId);
    this.route =
        listRoute.map((route) => RouteViewModel(route: route)).toList();
    if (route == null) {
      loadingStatus = LoadingStatus.empty;
    } else {
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
    return listRoute;
  }
}
