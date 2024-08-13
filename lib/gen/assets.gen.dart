/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsAudioGen {
  const $AssetsAudioGen();

  /// File path: assets/audio/cloud_cleared.mp3
  String get cloudCleared => 'assets/audio/cloud_cleared.mp3';

  /// File path: assets/audio/game_key_tap.mp3
  String get gameKeyTap => 'assets/audio/game_key_tap.mp3';

  /// File path: assets/audio/game_over.mp3
  String get gameOver => 'assets/audio/game_over.mp3';

  /// File path: assets/audio/game_won.mp3
  String get gameWon => 'assets/audio/game_won.mp3';

  /// File path: assets/audio/load.mp3
  String get load => 'assets/audio/load.mp3';

  /// File path: assets/audio/normal.mp3
  String get normal => 'assets/audio/normal.mp3';

  /// List of all assets
  List<String> get values =>
      [cloudCleared, gameKeyTap, gameOver, gameWon, load, normal];
}

class $AssetsHelpGen {
  const $AssetsHelpGen();

  /// File path: assets/help/game_over.png
  AssetGenImage get gameOver =>
      const AssetGenImage('assets/help/game_over.png');

  /// File path: assets/help/home.png
  AssetGenImage get home => const AssetGenImage('assets/help/home.png');

  /// File path: assets/help/leaderboard.png
  AssetGenImage get leaderboard =>
      const AssetGenImage('assets/help/leaderboard.png');

  /// File path: assets/help/level.png
  AssetGenImage get level => const AssetGenImage('assets/help/level.png');

  /// File path: assets/help/playing.png
  AssetGenImage get playing => const AssetGenImage('assets/help/playing.png');

  /// File path: assets/help/prologue.png
  AssetGenImage get prologue => const AssetGenImage('assets/help/prologue.png');

  /// File path: assets/help/theme.png
  AssetGenImage get theme => const AssetGenImage('assets/help/theme.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [gameOver, home, leaderboard, level, playing, prologue, theme];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/app_icon.png
  AssetGenImage get appIcon => const AssetGenImage('assets/icons/app_icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [appIcon];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/alternative_bg.png
  AssetGenImage get alternativeBg =>
      const AssetGenImage('assets/images/alternative_bg.png');

  /// File path: assets/images/button_bg.png
  AssetGenImage get buttonBg =>
      const AssetGenImage('assets/images/button_bg.png');

  /// File path: assets/images/cloud1.png
  AssetGenImage get cloud1 => const AssetGenImage('assets/images/cloud1.png');

  /// File path: assets/images/cloud2.png
  AssetGenImage get cloud2 => const AssetGenImage('assets/images/cloud2.png');

  /// File path: assets/images/edgy_border.png
  AssetGenImage get edgyBorder =>
      const AssetGenImage('assets/images/edgy_border.png');

  /// File path: assets/images/gameplay_bg.png
  AssetGenImage get gameplayBg =>
      const AssetGenImage('assets/images/gameplay_bg.png');

  /// File path: assets/images/horizontal_stick.png
  AssetGenImage get horizontalStick =>
      const AssetGenImage('assets/images/horizontal_stick.png');

  /// File path: assets/images/page_bg.png
  AssetGenImage get pageBg => const AssetGenImage('assets/images/page_bg.png');

  /// File path: assets/images/pos1.png
  AssetGenImage get pos1 => const AssetGenImage('assets/images/pos1.png');

  /// File path: assets/images/pos2.png
  AssetGenImage get pos2 => const AssetGenImage('assets/images/pos2.png');

  /// File path: assets/images/pos3.png
  AssetGenImage get pos3 => const AssetGenImage('assets/images/pos3.png');

  /// File path: assets/images/winner_trophy.png
  AssetGenImage get winnerTrophy =>
      const AssetGenImage('assets/images/winner_trophy.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        alternativeBg,
        buttonBg,
        cloud1,
        cloud2,
        edgyBorder,
        gameplayBg,
        horizontalStick,
        pageBg,
        pos1,
        pos2,
        pos3,
        winnerTrophy
      ];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/ecotyper_logo.png
  AssetGenImage get ecotyperLogo =>
      const AssetGenImage('assets/logo/ecotyper_logo.png');

  /// File path: assets/logo/typeninja_logo.png
  AssetGenImage get typeninjaLogo =>
      const AssetGenImage('assets/logo/typeninja_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [ecotyperLogo, typeninjaLogo];
}

class Assets {
  Assets._();

  static const $AssetsAudioGen audio = $AssetsAudioGen();
  static const $AssetsHelpGen help = $AssetsHelpGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
