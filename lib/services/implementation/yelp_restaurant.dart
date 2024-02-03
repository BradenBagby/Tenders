import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tenders/core/utility/environment.dart';
import 'package:tenders/core/utility/utility.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:tenders/services/interfaces/i_restauraunt.dart';

class YelpRestaurant implements IRestauraunt {
  static const NEARBY_URL = "place/nearbysearch/json";

  static final Dio dio = Dio(BaseOptions(
    receiveTimeout: Duration(milliseconds: 6000),
    connectTimeout: Duration(milliseconds: 10000),
    headers: {
      "Access-Control-Allow-Origin": "https://api.yelp.com/v3",
      "Access-Control-Request-Methods": "GET"
    },
    baseUrl: "https://api.yelp.com/v3/",
  ))
    ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      log('YELP: ${options.uri}');
      options.headers['Authorization'] = 'Bearer ${Environment.placesApiKey}';
      return handler.next(options);
    }));
  @override
  Future<Restauraunt> getAllInfo(Restauraunt restauraunt) async {
    try {
      String url = 'businesses/${restauraunt.id}'; // TODO: add term back in
      final uri = Uri.encodeFull(url);
      final result = await dio.get(uri);
      final data = toMap(result.data);

      return Restauraunt.fromYelpJson(data);
    } catch (err) {
      log("error loading restaurant: $err");
      return restauraunt;
    }
  }

  @override
  Future<List<Restauraunt>> load(
      {required LocationData location,
      int? offset,
      int limit = 20,
      required RoomSettings settings}) async {
    try {
      String url =
          'businesses/search?latitude=${settings.latitude}&longitude=${settings.longitude}&radius=${settings.radius}&limit=$limit&open_now=${settings.openNow}'; // TODO: add term back in
      if (settings.query.isNotEmpty) {
        url = '$url&term=${settings.query}&';
      }
      if (offset != null) {
        url = '$url&offset=$offset&';
      }
      final uri = Uri.encodeFull(url);
      final result = await dio.get(uri);
      final data = toMap(result.data);
      final businesses = toList(data['businesses']);

      return businesses.map((e) => Restauraunt.fromYelpJson(e)).toList();
    } catch (err) {
      log("error loading restaurants: $err");
      return [];
    }
  }

  @override
  String urlForPhoto(Photo photo) {
    return photo.photoReference;
  }
}
