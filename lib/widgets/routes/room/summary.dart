import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/application/room/cubit/room_cubit.dart';
import 'package:tenders/application/room_auth/room_auth_cubit.dart';
import 'package:tenders/core/utility/constants.dart';
import 'package:tenders/core/utility/environment.dart';
import 'package:tenders/core/utility/route_controllers.dart';
import 'package:tenders/domain/accepted/accepted.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/services/interfaces/i_room.dart';
import 'package:tenders/widgets/common/custom/spinner.dart';
import 'package:tenders/widgets/common/displays/accepted_row.dart';
import 'package:tenders/widgets/common/displays/avatar.dart';
import 'package:tenders/widgets/common/displays/restaurant_row.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';
import 'package:tenders/widgets/routes/soulmate/soulmate_info.dart';
import 'package:tenders/widgets/routes/soulmate/soulmate_page.dart';
import 'package:tuple/tuple.dart';
import 'package:collection/collection.dart';

import '../../root_widget.dart';

class SummaryWidget extends StatefulWidget {
  final bool standalone;
  const SummaryWidget({this.standalone = false});
  @override
  State<SummaryWidget> createState() => _SummaryState();
}

class _SummaryState extends State<SummaryWidget> {
  List<Accepted>? accepted;

  @override
  void initState() {
    final currentroom =
        GetIt.I<RoomAuthCubit>().state.currentRoomCubit!.state.room;

    if (Environment.marketing && kDebugMode) {
      setState(() {
        accepted = Constants.fakeAccepted;
      });
    } else {
      GetIt.I<IRoom>().getAllAccepted(currentroom.id).then((value) {
        setState(() {
          accepted = value;
        });
      });
    }

    // if it is not a standalone then we want to popup the soulmate page automatically
    if (!widget.standalone) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
        int tries = 0;
        while (accepted == null) {
          await Future.delayed(const Duration(milliseconds: 100));
          tries++;
          if (tries > 50) {
            return;
          }
        }
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => SoulmatePage(accepted!.first),
              fullscreenDialog: true),
        );
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
        )),
        Positioned.fill(
          child: Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/stcharles.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: BlocBuilder<RoomCubit, RoomState>(builder: (context, state) {
            final Accepted? soulmate = accepted?.firstOrNull;
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (soulmate == null) return;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => SoulmatePage(soulmate),
                          fullscreenDialog: true));
                    },
                    child: Material(
                      elevation: 2,
                      child: Container(
                          padding: EdgeInsets.all(8),
                          height: size / 2,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [primaryColor, secondaryColor])),
                          child: soulmate != null
                              ? Stack(
                                  children: [
                                    Positioned.fill(
                                      child: SoulmateInfo(
                                        soulmate,
                                        sizeMultiplier: size < 700 ? 0.65 : 0.8,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (_) => SoulmatePage(
                                                        soulmate,
                                                        autoShare: true,
                                                      ),
                                                  fullscreenDialog: true));
                                        },
                                        icon: Icon(
                                          Icons.ios_share_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox()),
                    ),
                  ),
                  Expanded(
                    child: accepted == null
                        ? _loadingSummary()
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, i) {
                              if (i == 0) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      if (state.room.settings.locationString !=
                                          null)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              "${state.room.settings.query} in ${state.room.settings.locationString!}:"),
                                        ),
                                      ...state.members
                                          .map((e) => Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Avatar(member: e),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(e.name),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    if (accepted != null)
                                                      Text(
                                                        "- ${accepted!.where((element) => element.accepted.contains(e.id)).length} Swipes Right",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption,
                                                      )
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                    ]);
                              }
                              final index = i - 1;
                              return AcceptedRow(accepted![
                                  index]); // TOOD: members that accepted
                            },
                            itemCount: accepted!.length + 1,
                          ),
                  )
                ],
              ),
            );
          }),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                    color: Theme.of(context).colorScheme.onBackground,
                    onPressed: () {
                      if (widget.standalone) {
                        Navigator.of(context).pop();
                      } else {
                        Scaffold.of(context).openDrawer();
                      }
                    },
                    icon: Icon(
                      widget.standalone ? Icons.close : Icons.menu,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _loadingSummary() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Loading Summary", style: Theme.of(context).textTheme.headline4),
          SizedBox(
            height: 8,
          ),
          Loader()
        ],
      ),
    );
  }
}
