import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecotyper/features/app/bloc/app_bloc.dart';
import 'package:ecotyper/features/gameplay/bloc/gameplay_bloc.dart';
import 'package:ecotyper/features/gameplay/ui/widgets/cloud_container.dart';
import 'package:ecotyper/gen/assets.gen.dart';

class CloudItem extends StatefulWidget {
  const CloudItem({
    super.key,
    required this.text,
  });
  final String text;

  @override
  State<CloudItem> createState() => _CloudItemState();
}

class _CloudItemState extends State<CloudItem> {
  late AssetGenImage randomCloud;
  bool toFadeItem = false;

  @override
  void initState() {
    super.initState();
    randomCloud = _getRandomCloudImage();
  }

  @override
  Widget build(BuildContext context) {
    var gamePlayBloc = context.read<GameplayBloc>();
    if (toFadeItem) {
      //add score
      gamePlayBloc.incrementScore(toAdd: widget.text.length);

      //Play Sound
      context.read<AppBloc>().playCloudClearedSFX();
    }
    return toFadeItem
        ? CloudContainer(
            cloudImage: randomCloud,
            text: widget.text,
            onCompleteText: () {},
          ).animate().fadeOut(
              duration: const Duration(milliseconds: 700),
            )
        : CloudContainer(
            cloudImage: randomCloud,
            text: widget.text,
            onCompleteText: () {
              // When user types complete text
              // Fade item
              setState(() {
                toFadeItem = true;
              });
              gamePlayBloc.clearTypedText();
            },
          );
  }

  AssetGenImage _getRandomCloudImage() {
    int randomNumber = Random().nextInt(2);
    return randomNumber == 0 ? Assets.images.cloud1 : Assets.images.cloud2;
  }
}
