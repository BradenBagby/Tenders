import 'package:tenders/services/implementation/room.dart';
import 'package:tenders/services/interfaces/i_room.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_state.dart';
part 'room_cubit.freezed.dart';

/// TODO: listen to current room changes. if room ends then kick out with message
/// if room finds a match, display the match overtop everything
class RoomCubit extends Cubit<RoomState> {
  IRoom _auth;
  RoomCubit({required IRoom auth})
      : _auth = auth,
        super(const RoomState()) {}
}
