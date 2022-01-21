import 'package:location/location.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/domain/room_settings/room_settings.dart';
import 'package:tuple/tuple.dart';

abstract class IRestauraunt {
  /// load restauraunts returns list and next page token
  Future<Tuple2<List<Restauraunt>, String?>> load({
    required LocationData location,
    String? pageToken,
    required RoomSettings settings,
  });

  /// if fails, passes back original
  Future<Restauraunt> getAllInfo(Restauraunt restauraunt);

  String urlForPhoto(Photo photo, {int? maxWidth, int? maxHeight});
}
