import 'package:tenders/application/cubit/room_cubit.dart';
import 'package:tenders/services/implementation/room.dart';
import 'package:tenders/services/interfaces/i_room.dart';
import 'package:get_it/get_it.dart';

class Injection {
  const Injection._();
  static final getIt = GetIt.I;

  /// sets up injection for email
  static Future<void> setup() {
    // services
    getIt.registerSingleton<IRoom>(Room());

    // singleton blocs
    getIt.registerSingleton<RoomCubit>(RoomCubit(auth: GetIt.I<IRoom>()));

    return GetIt.I.allReady();
  }
}
