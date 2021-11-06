import 'package:location/location.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';

abstract class IRestauraunt {
  Future<List<Restauraunt>> load({
    required LocationData location,
    String? pageToken,
    int radiusMeters = 25,
  });
}
