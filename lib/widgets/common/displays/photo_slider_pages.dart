import 'package:flutter/material.dart';
import 'package:tenders/domain/restauraunt/photo.dart';
import 'package:tenders/widgets/common/custom/page_indicator.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';

class PhotoSliderPages extends StatefulWidget {
  final List<Photo> photots;
  final int startIndex;
  const PhotoSliderPages(this.photots, {this.startIndex = 0});
  @override
  State<PhotoSliderPages> createState() => _PhotoSliderPagesState();
}

class _PhotoSliderPagesState extends State<PhotoSliderPages> {
  late final PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.startIndex);
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black.withAlpha(220),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: URLImage(
                        widget.photots[index].url(),
                        heroTag: widget.photots[index].photoReference,
                      ),
                    );
                  },
                  itemCount: widget.photots.length,
                ),
              ),
              PageIndicator(
                  pageCount: widget.photots.length,
                  currentPage: controller.hasClients
                      ? controller.page!.round()
                      : widget.startIndex)
            ],
          ),
        ));
  }
}
