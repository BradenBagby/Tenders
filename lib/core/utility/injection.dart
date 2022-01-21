import 'package:tenders/application/ads/ads_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/services/implementation/auth.dart';
import 'package:tenders/services/implementation/google_restauraunt.dart';
import 'package:tenders/services/implementation/room.dart';
import 'package:tenders/services/interfaces/i_auth.dart';
import 'package:tenders/services/interfaces/i_restauraunt.dart';
import 'package:tenders/services/interfaces/i_room.dart';
import 'package:get_it/get_it.dart';

class Injection {
  const Injection._();
  static final getIt = GetIt.I;

  /// sets up injection for email
  static Future<void> setup() {
    // services
    getIt.registerSingleton<IRoom>(FireRoom());
    getIt.registerSingleton<IAuth>(Auth());
    getIt.registerSingleton<IRestauraunt>(GoogleRestauraunt());

    // singleton blocs
    getIt.registerSingleton<RoomAuthCubit>(
        RoomAuthCubit(roomService: GetIt.I<IRoom>()));
    getIt.registerSingleton<AdsCubit>(AdsCubit());

    return GetIt.I.allReady();
  }
}
