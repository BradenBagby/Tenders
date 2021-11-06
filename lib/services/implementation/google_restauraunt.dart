import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';
import 'package:tenders/services/interfaces/i_restauraunt.dart';
import 'package:tuple/tuple.dart';

class GoogleRestauraunt implements IRestauraunt {
  static const API_KEY = "AIzaSyA6zyz3WKdq1W2SBTUHKdLAqND_fQxVZg0"; // TODO:
  static const NEARBY_URL = "place/nearbysearch/json";

  static final Dio dio =
      Dio(BaseOptions(baseUrl: "https://maps.googleapis.com/maps/api/"));

  @override
  Future<Tuple2<List<Restauraunt>, String?>> load({
    required LocationData location,
    String? pageToken,
    required RoomSettings settings,
  }) async {
    // TODO: catch errors
    String url =
        "place/nearbysearch/json?location=${GoogleRestaurauntURL.location(location)}&radius=${settings.radius}&type=${settings.type.toQueryString()}${settings.openNow ? '&opennow=true' : ''}&key=$API_KEY";
    if (pageToken != null) {
      url = "$url&pagetoken=$pageToken";
    }
    final uri = Uri.encodeFull(url);
    final res = await dio.get(uri);
    final data = Map<String, dynamic>.from(res.data as Map<dynamic, dynamic>);
    final nextPageToken = data['next_page_token'] as String?;
    if (data['status'] as String == "OK") {
      final listData =
          List<Map<String, dynamic>>.from(data['results'] as Iterable<dynamic>);
      final restauraunts =
          listData.map((e) => Restauraunt.fromGoogleJson(e)).toList();
      return Tuple2(restauraunts, nextPageToken);
    } else {
      // TODO
      return Tuple2(<Restauraunt>[], null);
    }
  }
}

/// helpers for generating urls
extension GoogleRestaurauntURL on GoogleRestauraunt {
  static String location(LocationData data) =>
      "${data.latitude},${data.longitude}";
}
