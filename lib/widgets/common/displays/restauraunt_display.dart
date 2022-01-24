import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/services/interfaces/i_restauraunt.dart';
import 'package:tenders/widgets/common/custom/spinner.dart';
import 'package:tenders/widgets/common/displays/contact.dart';
import 'package:tenders/widgets/common/displays/hours.dart';
import 'package:tenders/widgets/common/displays/navigation.dart';
import 'package:tenders/widgets/common/displays/photo_slider.dart';
import 'package:tenders/widgets/common/displays/reviews.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tenders/widgets/common/custom/size_measure.dart';
import 'dart:math' as math;
import 'dart:developer' as dev;

class RestaurauntDisplay extends StatefulWidget {
  final Restauraunt restauraunt;
  final bool scrollingEnabled;
  const RestaurauntDisplay(this.restauraunt,
      {this.scrollingEnabled = true, Key? key})
      : super(key: key);

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
      if (scrollController.hasClients) {
        setState(() {});
      }
    });

    // immediately get full restauraunt for display
    GetIt.I<IRestauraunt>().getAllInfo(widget.restauraunt).then((value) {
      if (mounted)
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: URLImage(widget.restauraunt.photos.first
                  .url(maxHeight: 1200, maxWidth: 800)),
            ),
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
        physics: widget.scrollingEnabled
            ? BouncingScrollPhysics()
            : NeverScrollableScrollPhysics(),
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
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _expandedInfo(),
              ),
            ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hours(allInfo!),
        SizedBox(
          height: 48,
        ),
        Navigation(allInfo!),
        SizedBox(
          height: 48,
        ),
        Reviews(allInfo!),
        SizedBox(
          height: 48,
        ),
        PhotoSlider(allInfo!.photos),
        SizedBox(
          height: 48,
        ),
        Contact(allInfo!)
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  20,
                ),
                topRight: Radius.circular(20),
              ),
              color: Colors.black
                  .withAlpha((100.0 * (1.0 - titlePercent)).toInt()),
            ),
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
                      Text(" (${widget.restauraunt.totalRatings.toString()})",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: titleColor))
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
