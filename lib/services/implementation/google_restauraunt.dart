import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:tenders/core/utility/constants.dart';
import 'package:tenders/core/utility/environment.dart';
import 'package:tenders/core/utility/utility.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';
import 'package:tenders/services/interfaces/i_restauraunt.dart';
import 'package:tuple/tuple.dart';

class GoogleRestauraunt implements IRestauraunt {
  String get API_KEY => Environment.placesApiKey; // TODO:
  static const NEARBY_URL = "place/nearbysearch/json";

  static final Dio dio = Dio(BaseOptions(
    receiveTimeout: 6000,
    connectTimeout: 10000,
    headers: {
      "Access-Control-Allow-Origin": "https://maps.googleapis.com/maps/api/",
      "Access-Control-Request-Methods": "GET"
    },
    baseUrl: "https://maps.googleapis.com/maps/api/",
  ));

  @override
  Future<Tuple2<List<Restauraunt>, String?>> load({
    required LocationData location,
    String? pageToken,
    required RoomSettings settings,
  }) async {
    if (Environment.marketing) {
      return Tuple2(Constants.fakeRestauraunts, null);
    }
    try {
      // TODO: catch errors
      String url =
          "place/nearbysearch/json?location=${GoogleRestaurauntURL.location(location)}&radius=${settings.radius}&type=${settings.type.toQueryString()}${settings.openNow ? '&opennow=true' : ''}&key=$API_KEY&rankby=prominence";
      if (pageToken != null) {
        url = "$url&pagetoken=$pageToken";
      }
      final uri = Uri.encodeFull(url);
      final res = await dio.get(uri);
      final data = Map<String, dynamic>.from(res.data as Map<dynamic, dynamic>);
      final nextPageToken = data['next_page_token'] as String?;
      if (data['status'] as String == "OK") {
        final listData = List<Map<String, dynamic>>.from(
            data['results'] as Iterable<dynamic>);
        final restauraunts = listData
            .map((e) => Restauraunt.fromGoogleJson(e))
            .toList()
          ..shuffle();
        return Tuple2(restauraunts, nextPageToken);
      } else {
        log("error loading restaurants bad status: $data");
        return Tuple2(<Restauraunt>[], null);
      }
    } catch (er) {
      log("error loading restaurants: $er");
      return Tuple2(<Restauraunt>[], null);
    }
  }

  @override
  String urlForPhoto(Photo photo, {int? maxWidth, int? maxHeight}) {
    final url =
        'https://maps.googleapis.com/maps/api/place/photo?photoreference=${photo.photoReference}&sensor=false${maxHeight != null ? '&maxheight=$maxHeight' : ''}${maxWidth != null ? '&maxwidth=$maxWidth' : ''}&key=$API_KEY';
    return url;
  }

  @override
  Future<Restauraunt> getAllInfo(Restauraunt restauraunt) async {
    try {
      // TODO: catch errors
      List<String> fields = [
        'name',
        'place_id',
        'vicinity',
        'rating',
        'icon',
        'photos',
        'geometry',
        'opening_hours',
        'price_level',
        'reviews',
        'website',
        'url',
        'formatted_phone_number'
      ];
      String url =
          "place/details/json?place_id=${restauraunt.id}&fields=${fields.join(',')}&key=$API_KEY";
      final uri = Uri.encodeFull(url);
      final res = await dio.get(uri);
      final data = Map<String, dynamic>.from(res.data as Map<dynamic, dynamic>);
      if (data['status'] as String == "OK") {
        final map = toMap(data['result']);
        return Restauraunt.fromGoogleJson(map);
      } else {
        log("error loading restaurant bad status: $data");
        return restauraunt;
      }
    } catch (er) {
      log("error loading restaurant: $er");
      return restauraunt;
    }
  }
}

/// helpers for generating urls
extension GoogleRestaurauntURL on GoogleRestauraunt {
  static String location(LocationData data) =>
      "${data.latitude},${data.longitude}";
}
