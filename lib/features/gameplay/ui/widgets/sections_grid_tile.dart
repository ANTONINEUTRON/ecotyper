import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionsGridTile extends StatelessWidget {
  const SectionsGridTile({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
  });

  final Function()? onTap;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            style: BorderStyle.solid,
            color: Theme.of(context).colorScheme.tertiary,
            width: 4.sp,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.sp),
            bottomRight: Radius.circular(24.sp),
            bottomLeft: Radius.circular(4.sp),
            topRight: Radius.circular(24.sp),
          ),
        ),
        child: Card(
          elevation: 16.sp,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: Icon(icon,size: 45.sp,color: Theme.of(context).colorScheme.tertiary,),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 18.sp),
                  textAlign: TextAlign.center,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const Text("0/100"),
                //     FittedBox(
                //       child: RatingBar.builder(
                //         itemCount: 3,
                //         itemSize: 15,
                //         allowHalfRating: true,
                //         initialRating: 2,
                //         onRatingUpdate: (value) {},
                //         itemBuilder: (context, index) {
                //           return Icon(
                //             Icons.star,
                //             color: Colors.amber.shade600,
                //           );
                //         },
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
