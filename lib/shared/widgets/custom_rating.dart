import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  const CustomRatingBar({
    super.key,
    required this.rating,
  });
  final double rating;
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemCount: 3,
      itemSize: 15,
      allowHalfRating: true,
      initialRating: rating,
      onRatingUpdate: (value) {},
      ignoreGestures: true,
      itemBuilder: (context, index) {
        return Icon(
          Icons.star,
          color: Colors.amber.shade600,
        );
      },
    );
  }
}
