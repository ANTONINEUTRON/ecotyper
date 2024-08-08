import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_state.dart';
import 'package:ecotyper/gen/assets.gen.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});

  static route() => MaterialPageRoute(
        builder: (context) => const PreviewPage(),
      );

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    GameplayState gamePlayState = context.read<GameplayBloc>().state;
    return Scaffold(
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.pageBg.provider(),
            opacity: 0.7,
            fit: BoxFit.fill,
          ),
        ),
      ),
      bottomSheet: SizedBox(
        height: screenSize.height * 0.92,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            horizontal: 16.sp,
          ),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.clear,
                  size: 30.sp,
                ),
              ),
            ),
            PassagePageThemeSection(
              text: gamePlayState.fact?.prologue ?? "",
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              gamePlayState.fact?.fact ?? "",
              style:
                  GoogleFonts.montserrat(fontSize: 24.sp, color: Colors.black),
              textAlign: TextAlign.justify,
            ),
            // RichText(text: text)
          ],
        ),
      ),
    );
  }
}

class PassagePageThemeSection extends StatelessWidget {
  const PassagePageThemeSection({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.images.buttonBg.provider(),
          fit: BoxFit.fill,
        ),
      ),
      padding: EdgeInsets.all(24.sp),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.robotoCondensed(
            color: Colors.white70,
            fontSize: 18.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
