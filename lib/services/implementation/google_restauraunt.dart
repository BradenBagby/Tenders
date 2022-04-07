import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:uuid/uuid.dart';
/*
class GoogleRestauraunt implements IRestauraunt {
  String get API_KEY => Environment.placesApiKey; // TODO:
  static const NEARBY_URL = "place/nearbysearch/json";
  static CollectionReference get cacheCollection =>
      FirebaseFirestore.instance.collection("cache");
  static CollectionReference get cacheMoreInfoCollection =>
      FirebaseFirestore.instance.collection("cacheMoreInfo");

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
      final String locationString = GoogleRestaurauntURL.location(location);

      String url =
          "place/nearbysearch/json?location=${locationString}&radius=${settings.radius}${pageToken == null ? '' : '&pagetoken=$pageToken'}&keyword=${settings.query}${settings.openNow ? '&opennow=true' : ''}&key=$API_KEY&rankby=prominence";

      final keyStringIndex = url.indexOf("&key=");
      final urlCache = url.substring(0, keyStringIndex);

      /// check cache see if it exists

      Map<String, dynamic>? data;
      final query =
          await cacheCollection.where("url", isEqualTo: urlCache).get();
      if (query.docs.isNotEmpty) {
        try {
          // found data in the cache
          final doc = query.docs.first;
          data = toMap(toMap(doc.data())["data"]);
        } catch (er) {
          log("Failed to get from cache !!!!!!!!!!!!!!!!");
          data = null;
        }
      }

      // if cache failed
      if (data == null) {
        // load data from google for a whopping 1 cent
        final uri = Uri.encodeFull(url);
        final res = await dio.get(uri);
        data = Map<String, dynamic>.from(res.data as Map<dynamic, dynamic>);

        if (data['status'] as String == "OK") {
          final cacheQueryInfo = {"url": urlCache, "data": data};
          await cacheCollection.doc().set(cacheQueryInfo);
        }
      }

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
  String urlForPhoto(Photo photo) {
    final url =
        'https://maps.googleapis.com/maps/api/place/photo?photoreference=${photo.photoReference}&sensor=false&maxheight=1200&maxwidth=800&key=$API_KEY';
    return url;
  }

  @override
  Future<Restauraunt> getAllInfo(Restauraunt restauraunt) async {
    Map<String, dynamic>? data;

    try {
      final cacheInfo = await cacheMoreInfoCollection.doc(restauraunt.id).get();

      if (cacheInfo.exists) {
        try {
          data = toMap(cacheInfo.data());
        } catch (er) {
          data = null;
        }
      }

      if (data == null) {
        List<String> fields = [
          'name',
          'place_id',
          'vicinity',
          'rating',
          'icon',
          //   'photos',
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
        data = Map<String, dynamic>.from(res.data as Map<dynamic, dynamic>);

        // cache
        if (data['status'] as String == "OK") {
          await cacheMoreInfoCollection.doc(restauraunt.id).set(data);
        }
      }

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

*/