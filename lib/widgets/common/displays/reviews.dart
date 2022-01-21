import 'package:flutter/material.dart';
import 'package:tenders/domain/restauraunt/restauraunt.dart';
import 'package:tenders/domain/restauraunt/review.dart';
import 'package:tenders/widgets/common/displays/url_image.dart';

class Reviews extends StatelessWidget {
  final Restauraunt restauraunt;

  const Reviews(this.restauraunt);
  @override
  Widget build(BuildContext context) {
    if (restauraunt.reviews.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reviews",
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          height: 4,
        ),
        Column(
          children: restauraunt.reviews.map((e) => ReviewWidget(e)).toList(),
        )
      ],
    );
  }
}

class ReviewWidget extends StatefulWidget {
  final Review review;

  const ReviewWidget(this.review);

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: URLImage(
                        widget.review.profile_photo_url,
                        failedWidget: Container(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.review.author_name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            ...List.generate(
                                widget.review.rating.toInt(),
                                (index) => Icon(
                                      Icons.star,
                                      size: 16,
                                    ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Text(
                widget.review.text,
                maxLines: expanded ? 99 : 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
