import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ecotyper/features/account/bloc/account_bloc.dart';
import 'package:ecotyper/features/account/ui/pages/signin_page.dart';
import 'package:ecotyper/features/account/ui/widgets/avatar_widget.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/fact_card_toshare.dart';
import 'package:ecotyper/shared/constants.dart';

class HighlightedPassage extends StatefulWidget {
  const HighlightedPassage({
    Key? key,
    required this.passage,
    required this.wordsToHighlight,
  }) : super(key: key);

  final String passage;
  final List<String> wordsToHighlight;

  @override
  State<HighlightedPassage> createState() => _HighlightedPassageState();
}

class _HighlightedPassageState extends State<HighlightedPassage> {
  ScreenshotController controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    var user = context.watch<AccountBloc>().state.user;
    String userPics = user?.displayPics ?? "";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "PLAYED FACT",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
              textAlign: TextAlign.center,
            ),
            IconButton(
              onPressed: () {
                //
                if (user == null) {
                  Navigator.push(
                    context,
                    SigninPage.route(),
                  );
                } else {
                  sharePlayedFact(
                    userDP:
                        // Passed the url because it will prevent error
                        AvatarWidget(
                      size: 50,
                      urlToBeUsed: userPics,
                    ),
                    userName: user.name,
                  );
                }
              },
              icon: Icon(
                Icons.share,
                color: Theme.of(context).colorScheme.tertiary,
                size: 36.sp,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.h,
        ),
        RichText(
          text: TextSpan(
            children: buildSpans(
              widget.passage,
              widget.wordsToHighlight,
            ),
          ),
        ),
      ],
    );
  }

  List<TextSpan> buildSpans(
    String passage,
    List<String> words,
  ) {
    List<TextSpan> spans = [];

    List<String> splits =
        passage.replaceAll(".", "").replaceAll(",", "").split(" ");
    for (var word in splits) {
      // If words contain the word, it should be green
      if (words.contains(word)) {
        spans.add(
          TextSpan(
            text: "$word ",
            style: GoogleFonts.montserrat(
              fontSize: 20.sp,
              color: Colors.green.shade800,
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: "$word ",
            style: GoogleFonts.montserrat(
              fontSize: 20.sp,
              color: Colors.black,
            ),
          ),
        );
      }
    }
    return spans;
  }

  /// Needed so that all widgets will be ready before being passed to FactCardToShare widget
  void sharePlayedFact({
    required Widget userDP,
    required String userName,
  }) async {
    //get ui
    Widget uiToScreenshot = FactCardToShare(
      fact: widget.passage,
      textColor: Theme.of(context).colorScheme.tertiary,
      toShowAboveFact: Row(
        children: [
          userDP,
          SizedBox(
            width: 4.w,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "Knows that...",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            ],
          ),
        ],
      ),
      toShowUnderFact: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "${AppConstants.appName}",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );

    //take screenshot
    Uint8List capturedImage =
        await controller.captureFromWidget(uiToScreenshot);

    //save screenshot
    final directory = await getTemporaryDirectory();
    final imageFile = await File('${directory.path}/image.png').create();
    await imageFile.writeAsBytes(capturedImage);

    //share file with user
    await Share.shareXFiles([XFile(imageFile.path)]);
  }
}
