import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_etourguide/etourguide_model/event_model.dart';
import 'package:flutter_etourguide/etourguide_model/exhibit_model.dart';
import 'package:flutter_etourguide/etourguide_model/feedback_model.dart';
import 'package:flutter_etourguide/etourguide_model/icon_room_model.dart';
import 'package:flutter_etourguide/etourguide_model/map_model.dart';
import 'package:flutter_etourguide/etourguide_model/room_model.dart';
import 'package:flutter_etourguide/etourguide_model/route_model.dart';
import 'package:flutter_etourguide/etourguide_model/search_data_model.dart';
import 'package:flutter_etourguide/etourguide_model/topic_model.dart';

class WebService {
  String api = 'http://trunghieu.cosplane.asia/api/';
  var dio = new Dio();
  Future<List<Event>> fetchSuggestionEvent() async {
    String url = api + 'event/suggest/highlight/event';
    await Future.delayed(Duration(milliseconds: 500));
    final response = await dio.get(url, options: Options(
      contentType: 'application/json; charset=utf-8',
    ));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((event) => Event.fromJson(event)).toList();
    } else {
      throw Exception("Failed to get suggestion event");
    }
  }

  Future<List<Topic>> fetchSuggestionTopic() async {
    String url = api + 'topic/suggest/highlight/topic';
    await Future.delayed(Duration(milliseconds: 500));
    final response = await dio.get(url, options: Options(
      contentType: 'application/json; charset=utf-8',
    ));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((topic) => Topic.fromJson(topic)).toList();
    } else {
      throw Exception("Failed to get suggestion topic");
    }
  }

  Future<List<Exhibit>> fetchSuggestionExhibit() async {
    String url = api + 'exhibit/suggest/highlight/exhibit';
    await Future.delayed(Duration(milliseconds: 500));
    final response = await dio.get(url, options: Options(
      contentType: 'application/json; charset=utf-8',
    ));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((exhibit) => Exhibit.fromJson(exhibit)).toList();
    } else {
      throw Exception("Failed to get suggestion exhibit");
    }
  }

  Future<List<Event>> fetchAllEvent() async {
    String url = api + 'event';
    await Future.delayed(Duration(milliseconds: 500));
    final response = await dio.get(url, options: Options(
      contentType: 'application/json; charset=utf-8',
    ));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((event) => Event.fromJson(event)).toList();
    } else {
      throw Exception("Failed to get all event");
    }
  }

  Future<List<Topic>> fetchAllTopic() async {
    String url = api + 'topic';
    await Future.delayed(Duration(milliseconds: 500));
    final response = await dio.get(url, options: Options(
      contentType: 'application/json; charset=utf-8',
    ));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((topic) => Topic.fromJson(topic)).toList();
    } else {
      throw Exception("Failed to get all topic");
    }
  }

  Future<List<Exhibit>> fetchAllExhibit() async {
    String url = api + 'exhibit';
    await Future.delayed(Duration(milliseconds: 500));
    final response = await dio.get(url, options: Options(
      contentType: 'application/json; charset=utf-8',
    ));

    if (response.statusCode == 200) {
//      print(response.data);
      final result = response.data;
      Iterable list = result;
      return list.map((exhibit) => Exhibit.fromJson(exhibit)).toList();
    } else {
      throw Exception("Failed to get all exhibit");
    }
  }

  Future<List<Room>> fetchAllRoom() async {
    String url = api + 'room/get/all/room';

    final response = await dio.get(url, options: Options(
      contentType: 'application/json; charset=utf-8',
    ));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((room) => Room.fromJson(room)).toList();
    } else {
      throw Exception("Failed to get all room");
    }
  }

  Future<List<Exhibit>> fetchAllExhibitInRoom(int roomId) async {
    String url = api + 'room/get/exhibit/from/room?roomId=${roomId}';

    final response = await dio.get(url, options: Options(
      contentType: 'application/json; charset=utf-8',
    ));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((exhibit) => Exhibit.fromJson(exhibit)).toList();
    } else {
      throw Exception("Failed to get exhibit in room with roomId=${roomId}");
    }
  }

  Future<List<Exhibit>> fetchExhibitInEvent(int eventId) async {
    String url = api +
        'exhibit-in-event/get/exhibit/in/event/for/user?eventId=${eventId}';
    await Future.delayed(Duration(milliseconds: 500));
    final response = await dio.get(url, options: Options(
      contentType: 'application/json; charset=utf-8',
    ));
    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((exhibit) => Exhibit.fromJson(exhibit)).toList();
    } else {
      throw Exception("Failed to get exhibit in event");
    }
  }

  Future<List<Exhibit>> fetchCurrentExhibit() async {
    String url = api + 'exhibit/recently/createdate/exhibit';

    final response = await dio.get(url, options: Options(
      contentType: 'application/json; charset=utf-8',
    ));
    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((exhibit) => Exhibit.fromJson(exhibit)).toList();
    } else {
      throw Exception("Failed to get current exhibit");
    }
  }

  Future<List<Exhibit>> fetchExhibitInTopic(int topicId) async {
    String url = api +
        'exhibit-in-topic/get/exhibit/in/topic/for/user?topicId=${topicId}';

    final response = await dio.get(url, options: Options(
      contentType: 'application/json; charset=utf-8',
    ));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((exhibit) => Exhibit.fromJson(exhibit)).toList();
    } else {
      throw Exception("Failed to get exhibit in topic");
    }
  }

  Future<List<SearchData>> fetchDataByName(
      String name, String language_code) async {
    String url =
        api + 'user/search-by-name?language=${language_code}&name=${name}';
    final response = await dio.get(url, options: Options(
      contentType: 'application/json; charset=utf-8',
    ));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((data) => SearchData.fromJson(data)).toList();
    } else {
      throw Exception("Failed to get data by this name: ${name}");
    }
  }

  Future<List<Exhibit>> fetchExhibitInDuration(String time) async {
    String url = api + 'duration/duration-for-time?Time=${time}';

    final response = await dio.get(url, options: Options(
      contentType: 'application/json; charset=utf-8',
    )
    );

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((exhibit) => Exhibit.fromJson(exhibit)).toList();
    } else {
      throw Exception("Failed to get exhibit in duration ${time}");
    }
  }

  Future<String> fetchEventInDuration(
      String eventId, List<String> exhibitId) async {
    String url = api +
        'duration/total-time-to-move-and-visit-exhibit-in-a-event?eventId=${eventId}';

    final response = await dio.post(url, data: jsonEncode(exhibitId));

    if (response.statusCode == 200) {
      final result = response.data;
      String duration = result;
      return duration;
    } else {
      throw Exception("Failed to get exhibit in event with id: ${eventId}");
    }
  }

  Future<String> fetchGetMap(int floor) async {
    String url = api + 'map/get-map-image-by-floor-for-user?FloorId=${floor}';

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      String url = result;
      return url;
    } else {
      throw Exception("Failed to get map with floor: ${floor}");
    }
  }

  Future<String> fetchTopicInDuration(
      String topicId, List<String> exhibitId) async {
    //String url = api + 'duration/total-time-to-move-and-visit-exhibit-in-a-event?eventId=${eventId}';
    String url = api +
        'duration/total-time-to-move-and-visit-exhibit-in-a-topic?topicId=${topicId}';
    final response = await dio.post(url, data: jsonEncode(exhibitId));
    //final responses =  dio.get(url, queryParameters: exhibitId);
    if (response.statusCode == 200) {
      final result = response.data;
      String duration = result;
      return duration;
    } else {
      throw Exception("Failed to get exhibit in event with id: ${topicId}");
    }
  }

  Future<List<Event>> fetchCurrentEvent() async {
    String url = api + 'event/current/event';
    await Future.delayed(Duration(milliseconds: 500));
    //await Future.delayed(Duration(seconds: 3));
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final result = response.data;
      //print(response.statusMessage);
      Iterable list = result;
      return list.map((event) => Event.fromJson(event)).toList();
    } else {
      //  print(Exception().toString());
      throw Exception("Failed to get current event");
    }
  }

  Future<int> fetchFeedbackAnEvent(FeedBack feedBack) async {
    String url = api + 'feedback/add/event/feedback/from/user';

    final response = await dio.post(url,
        data: jsonEncode(<String, dynamic>{
          "eventId": feedBack.eventId,
          "visitorName": "${feedBack.visitorName}",
          "rating": feedBack.rating,
          "description": "${feedBack.description}"
        }));
//    print("response:" + response.toString());
    if (response.statusCode == 200) {
      final result = response.data;
      //String duration = result;
      return result;
    } else {
      throw Exception(
          "Failed to add feedback for this eventId: ${feedBack.eventId}!");
    }
  }

  Future<int> fetchFeedbackAnTopic(FeedBack feedBack) async {
    String url = api + 'feedback/add/topic/feedback/from/user';

    final response = await dio.post(url,
        data: jsonEncode(<String, dynamic>{
          "topicId": feedBack.topicId,
          "visitorName": "${feedBack.visitorName}",
          "rating": feedBack.rating,
          "description": "${feedBack.description}"
        }));
//    print("response:" + response.toString());
    if (response.statusCode == 200) {
      final result = response.data;
      //String duration = result;
      return result;
    } else {
      throw Exception(
          "Failed to add feedback for this topicId: ${feedBack.topicId}!");
    }
  }

  Future<List<FeedBack>> fetchFeedbackInEvent(int eventId) async {
    String url = api + 'feedback/event/feedback/id=${eventId}';

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((fb) => FeedBack.fromJson(fb)).toList();
    } else {
      throw Exception("Failed to get list feedback in eventId: ${eventId}");
    }
  }

  Future<List<FeedBack>> fetchFeedbackInTopic(int topicId) async {
    String url = api + 'feedback/topic/feedback/id=${topicId}';

    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((fb) => FeedBack.fromJson(fb)).toList();
    } else {
      throw Exception("Failed to get list feedback in eventId: ${topicId}");
    }
  }

  Future<List<RouteModel>> fetchRouteByExhibit(List<String> exhibitId) async {
    String url = api + 'duration/suggest-route-base-on-exhibit';

    final response = await dio.post(url, data: jsonEncode(exhibitId));

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((route) => RouteModel.fromJson(route)).toList();
    } else {
      throw Exception("Failed to get route by exhibitId");
    }
  }

  Future<List<RouteModel>> fetchRouteBackToStartPoint(int roomId) async {
    String url = api + 'shortest-path-and-suggest-route/suggest-route-to-back-to-startpoint?roomId=${roomId}';
    await Future.delayed(Duration(milliseconds: 500));
    final response = await dio.post(url);

    if (response.statusCode == 200) {
      final result = response.data;
      Iterable list = result;
      return list.map((route) => RouteModel.fromJson(route)).toList();
    } else {
      throw Exception("Failed to get route when using scanQR");
    }
  }

  Future<List<Maps>> fetchAllPosition() async {
    String url = api + 'position/get-all-positions-for-app';
    await Future.delayed(Duration(milliseconds: 500));
    //await Future.delayed(Duration(seconds: 3));
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final result = response.data;
      //print(response.statusMessage);
      Iterable list = result;
      return list.map((map) => Maps.fromJson(map)).toList();
    } else {
      //print(Exception().toString());
      throw Exception("Failed to get all position in map");
    }
  }



  Future<List<IconRoom>> fetchAllIconRoomButton(int floorId) async {
    String url = api + 'position/get-positions-for-room?floorId=${floorId}';
    await Future.delayed(Duration(milliseconds: 500));
    //await Future.delayed(Duration(seconds: 3));
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final result = response.data;
      //print(response.statusMessage);
      Iterable list = result;
      return list.map((map) => IconRoom.fromJson(map)).toList();
    } else {
      //print(Exception().toString());
      throw Exception("Failed to get all icon room button in map");
    }
  }

  Future<String> fetchTextByPosition(String language, List<dynamic> position) async {
    String url = api + 'shortest-path-and-suggest-route/get-text-route-from-position?language=${language}';

    final response = await dio.post(url, data: jsonEncode(position));

    if (response.statusCode == 200) {
      final result = response.data;
      String url = result;
      return url;
    } else {
      throw Exception("Failed to get text by position");
    }
  }
}
