/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class Assets {
  const Assets._();

  static const AssetGenImage ac = AssetGenImage('assets/ac.png');
  static const AssetGenImage airCoolerPng = AssetGenImage(
    'assets/air-cooler.png',
  );
  static const AssetGenImage airCoolerPng_ = AssetGenImage(
    'assets/air_cooler.png',
  );
  static const AssetGenImage appIcon = AssetGenImage('assets/appIcon.png');
  static const AssetGenImage battery = AssetGenImage('assets/battery.png');
  static const AssetGenImage bill = AssetGenImage('assets/bill.png');
  static const AssetGenImage calculator = AssetGenImage(
    'assets/calculator.png',
  );
  static const AssetGenImage coffeeMaker = AssetGenImage(
    'assets/coffee_maker.png',
  );
  static const AssetGenImage crashBulb = AssetGenImage('assets/crash_bulb.png');
  static const AssetGenImage dishwasher = AssetGenImage(
    'assets/dishwasher.png',
  );
  static const AssetGenImage dryer = AssetGenImage('assets/dryer.png');
  static const AssetGenImage electricity = AssetGenImage(
    'assets/electricity.png',
  );
  static const AssetGenImage electricityIcon = AssetGenImage(
    'assets/electricityIcon.png',
  );
  static const AssetGenImage fesco = AssetGenImage('assets/fesco.png');
  static const AssetGenImage freezer = AssetGenImage('assets/freezer.png');
  static const AssetGenImage generator = AssetGenImage('assets/generator.png');
  static const AssetGenImage gepco = AssetGenImage('assets/gepco.png');
  static const AssetGenImage geyser = AssetGenImage('assets/geyser.png');
  static const AssetGenImage handshake = AssetGenImage('assets/handshake.png');
  static const AssetGenImage hesco = AssetGenImage('assets/hesco.png');
  static const AssetGenImage highVolt = AssetGenImage('assets/high_volt.png');
  static const AssetGenImage iesco = AssetGenImage('assets/iesco.png');
  static const AssetGenImage iron = AssetGenImage('assets/iron.png');
  static const AssetGenImage kelectric = AssetGenImage('assets/kelectric.png');
  static const AssetGenImage ladySolar = AssetGenImage('assets/lady_solar.png');
  static const AssetGenImage laptop = AssetGenImage('assets/laptop.png');
  static const AssetGenImage lesco = AssetGenImage('assets/lesco.png');
  static const AssetGenImage light = AssetGenImage('assets/light.png');
  static const AssetGenImage mahine = AssetGenImage('assets/mahine.png');
  static const AssetGenImage mepco = AssetGenImage('assets/mepco.png');
  static const AssetGenImage metering = AssetGenImage('assets/metering.png');
  static const AssetGenImage microwave = AssetGenImage('assets/microwave.png');
  static const AssetGenImage moreApp = AssetGenImage('assets/more_app.png');
  static const AssetGenImage pesco = AssetGenImage('assets/pesco.png');
  static const AssetGenImage printer = AssetGenImage('assets/printer.png');
  static const AssetGenImage privayIcon = AssetGenImage(
    'assets/privay_icon.png',
  );
  static const AssetGenImage pump = AssetGenImage('assets/pump.png');
  static const AssetGenImage qesco = AssetGenImage('assets/qesco.png');
  static const AssetGenImage rateIcon = AssetGenImage('assets/rate_icon.png');
  static const AssetGenImage refrigerator = AssetGenImage(
    'assets/refrigerator.png',
  );
  static const AssetGenImage sepco = AssetGenImage('assets/sepco.png');
  static const AssetGenImage solarEnergy = AssetGenImage(
    'assets/solar-energy.png',
  );
  static const AssetGenImage solar = AssetGenImage('assets/solar.png');
  static const AssetGenImage splash = AssetGenImage('assets/splash.png');
  static const AssetGenImage tableBulb = AssetGenImage('assets/table_bulb.png');
  static const AssetGenImage teco = AssetGenImage('assets/teco.png');
  static const AssetGenImage tv = AssetGenImage('assets/tv.png');

  /// List of all assets
  static List<AssetGenImage> get values => [
    ac,
    airCoolerPng,
    airCoolerPng_,
    appIcon,
    battery,
    bill,
    calculator,
    coffeeMaker,
    crashBulb,
    dishwasher,
    dryer,
    electricity,
    electricityIcon,
    fesco,
    freezer,
    generator,
    gepco,
    geyser,
    handshake,
    hesco,
    highVolt,
    iesco,
    iron,
    kelectric,
    ladySolar,
    laptop,
    lesco,
    light,
    mahine,
    mepco,
    metering,
    microwave,
    moreApp,
    pesco,
    printer,
    privayIcon,
    pump,
    qesco,
    rateIcon,
    refrigerator,
    sepco,
    solarEnergy,
    solar,
    splash,
    tableBulb,
    teco,
    tv,
  ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
