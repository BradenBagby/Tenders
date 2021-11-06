import 'package:location/location.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tuple/tuple.dart';

abstract class IRestauraunt {
  /// load restauraunts returns list and next page token
  Future<Tuple2<List<Restauraunt>, String?>> load({
    required LocationData location,
    String? pageToken,
    int radiusMeters = 25,
  });
}
