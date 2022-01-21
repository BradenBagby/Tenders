import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/services/interfaces/i_restauraunt.dart';
import 'package:tenders/widgets/common/custom/spinner.dart';
import 'package:tenders/widgets/common/displays/photo_slider.dart';
import 'package:tenders/widgets/common/displays/reviews.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tenders/widgets/common/custom/size_measure.dart';
import 'dart:math' as math;

class RestaurauntDisplay extends StatefulWidget {
  final Restauraunt restauraunt;
  const RestaurauntDisplay(this.restauraunt);

  @override
  State<RestaurauntDisplay> createState() => _RestaurauntDisplayState();
}

class _RestaurauntDisplayState extends State<RestaurauntDisplay> {
  // available size once calcluated
  Size? availableSize;

  //size of title
  Size? titleSize;
  final scrollController = ScrollController();

  /// restaurant with all info loaded in
  Restauraunt? allInfo;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {});
    });

    // immediately get full restauraunt for display
    GetIt.I<IRestauraunt>().getAllInfo(widget.restauraunt).then((value) {
      setState(() {
        allInfo = value;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: _mainView(context, size),
      ),
    );
  }

  Widget _mainView(BuildContext context, Size size) {
    Widget current = Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          color: Theme.of(context).colorScheme.surface,
        ),
        if (widget.restauraunt.photos.isNotEmpty)
          Positioned.fill(
            child: URLImage(widget.restauraunt.photos.first.url(
                maxHeight: size.height.toInt() * 2,
                maxWidth: size.width.toInt() * 2)),
          ),
        Positioned.fill(
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [_overlay(context, size)],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SafeArea(
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        )
      ],
    );

    if (availableSize == null) {
      return MeasureSize(
        child: current,
        onChange: (size) {
          setState(() {
            availableSize = size;
          });
        },
      );
    } else {
      return SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              width: availableSize!.width,
              height: availableSize!.height,
              child: current,
            ),
            Container(
              color: Colors.transparent,
              height: titleSize?.height ?? 0,
            ),
            _expandedInfo(),
          ],
        ),
      );
    }
  }

  Widget _expandedInfo() {
    if (allInfo == null) {
      return Center(
        child: Loader(),
      );
    }
    return Column(
      children: [
        SizedBox(
          height: 48,
        ),
        Reviews(allInfo!),
        SizedBox(
          height: 48,
        ),
        PhotoSlider(allInfo!.photos),
      ],
    );
  }

  Widget _overlay(BuildContext context, Size size) {
    final double titlePercent = titleSize != null && scrollController.hasClients
        ? (math.min(titleSize!.height, scrollController.offset) /
            titleSize!.height)
        : 0;

    final titleColor = Color.lerp(
        Colors.white, Theme.of(context).colorScheme.onSurface, titlePercent);
    return Transform.translate(
      offset:
          Offset(0, titleSize != null ? titlePercent * titleSize!.height : 0),
      child: InkWell(
        onTap: () {
          if (scrollController.hasClients) {
            scrollController.animateTo(
                math.min(availableSize!.height,
                    scrollController.position.maxScrollExtent),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut);
          }
        },
        child: MeasureSize(
          onChange: (size) {
            if (titleSize != null) return;
            setState(() {
              titleSize = size;
            });
          },
          child: Container(
            padding: EdgeInsets.all(8),
            color:
                Colors.black.withAlpha((100.0 * (1.0 - titlePercent)).toInt()),
            child: SafeArea(
              top: false,
              bottom: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.restauraunt.name,
                    maxLines: 4,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ),
                  ),
                  Row(
                    children: [
                      ...List.generate(
                              widget.restauraunt.rating.toInt(), (x) => x)
                          .map((e) => Icon(
                                Icons.star,
                                color: titleColor,
                                size: 16,
                              ))
                          .toList(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
