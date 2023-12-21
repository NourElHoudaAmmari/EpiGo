import 'package:epigo_project/config/constants.dart';
import 'package:epigo_project/models/review_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ReviewUI extends StatefulWidget {
  final ReviewModal review;
  final VoidCallback onTap, onPressed;
  final bool isLess;

  const ReviewUI({
    Key? key,
    required this.review,
    required this.onTap,
    required this.onPressed,
    required this.isLess,
  }) : super(key: key);

  @override
  State<ReviewUI> createState() => _ReviewUIState();
}

class _ReviewUIState extends State<ReviewUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 2.0,
        bottom: 2.0,
        left: 16.0,
        right: 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                 '${widget.review.user?['name']}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: widget.onPressed, // Pass onPressed to IconButton
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              SmoothStarRating(
                starCount: 5,
                rating: widget.review.rating!,
                size: 28.0,
                color: Colors.orange,
                borderColor: Colors.orange,
              ),
              SizedBox(width: kFixPadding),
              Text(
                widget.review.date != null
                    ? DateFormat('dd-MM-yyyy HH:mm:ss')
                        .format(DateTime.parse(widget.review.date!))
                    : 'Date not available',
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: widget.onTap, // Pass onTap to GestureDetector
            child: widget.isLess
                ? Text(
                    '${widget.review.comment}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: kLightColor,
                    ),
                  )
                : Text(
                    '${widget.review.comment}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: kLightColor,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}