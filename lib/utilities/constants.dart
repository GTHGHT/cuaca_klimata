import 'package:flutter/material.dart';

const kWeatherImageList = <String>[
  "images/clear_white.png",
  "images/cloud_white.png",
  "images/rain_white.png",
  "images/snow_white.png",
  "images/storm_white.png",
  "images/dust_white.png",
];

const kLandingButtonTextStyle = TextStyle(
  fontFamily: "Lato",
  fontSize: 24,
);

final kClearCS = ColorScheme.fromSeed(
  seedColor: Color(0xFFFFDF22),
  brightness: Brightness.light,
);

final kClearDarkCS = ColorScheme.fromSeed(
  seedColor: Color(0xFFFFDF22),
  brightness: Brightness.dark,
);

final kCloudyCS = ColorScheme.fromSeed(
  seedColor: Color(0xFFB0C4DE),
  brightness: Brightness.light,
);

final kCloudyDarkCS = ColorScheme.fromSeed(
  seedColor: Color(0xFFB0C4DE),
  brightness: Brightness.dark,
);

final kFogCS = ColorScheme.fromSeed(
  seedColor: Color(0xFFD7D0FF),
  brightness: Brightness.light,
);

final kFogDarkCS = ColorScheme.fromSeed(
  seedColor: Color(0xFFD7D0FF),
  brightness: Brightness.dark,
);

const kDrizzleCS = ColorScheme(
  // #a0af9d
  brightness: Brightness.light,
  primary: Color(0xff00495d),
  surfaceTint: Color(0xff0c6780),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xff317d98),
  onPrimaryContainer: Color(0xffffffff),
  secondary: Color(0xff31464f),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xff627882),
  onSecondaryContainer: Color(0xffffffff),
  tertiary: Color(0xff404060),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xff727195),
  onTertiaryContainer: Color(0xffffffff),
  error: Color(0xff8c0009),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffda342e),
  onErrorContainer: Color(0xffffffff),
  surface: Color(0xfff5fafd),
  onSurface: Color(0xff171c1f),
  onSurfaceVariant: Color(0xff3c4448),
  outline: Color(0xff586064),
  outlineVariant: Color(0xff747c80),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2c3134),
  inversePrimary: Color(0xff89d0ed),
  primaryFixed: Color(0xff317d98),
  onPrimaryFixed: Color(0xffffffff),
  primaryFixedDim: Color(0xff05647e),
  onPrimaryFixedVariant: Color(0xffffffff),
  secondaryFixed: Color(0xff627882),
  onSecondaryFixed: Color(0xffffffff),
  secondaryFixedDim: Color(0xff4a5f69),
  onSecondaryFixedVariant: Color(0xffffffff),
  tertiaryFixed: Color(0xff727195),
  onTertiaryFixed: Color(0xffffffff),
  tertiaryFixedDim: Color(0xff59597b),
  onTertiaryFixedVariant: Color(0xffffffff),
  surfaceDim: Color(0xffd6dbde),
  surfaceBright: Color(0xfff5fafd),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xfff0f4f7),
  surfaceContainer: Color(0xffeaeef2),
  surfaceContainerHigh: Color(0xffe4e9ec),
  surfaceContainerHighest: Color(0xffdee3e6),
);

const kDrizzleDarkCS = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xff89d0ed),
  surfaceTint: Color(0xff89d0ed),
  onPrimary: Color(0xff003544),
  primaryContainer: Color(0xff004d62),
  onPrimaryContainer: Color(0xffbaeaff),
  secondary: Color(0xffb3cad5),
  onSecondary: Color(0xff1e333c),
  secondaryContainer: Color(0xff354a53),
  onSecondaryContainer: Color(0xffcfe6f1),
  tertiary: Color(0xffc4c3eb),
  onTertiary: Color(0xff2d2d4d),
  tertiaryContainer: Color(0xff444465),
  onTertiaryContainer: Color(0xffe2dfff),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffdad6),
  surface: Color(0xff0f1417),
  onSurface: Color(0xffdee3e6),
  onSurfaceVariant: Color(0xffc0c8cc),
  outline: Color(0xff8a9296),
  outlineVariant: Color(0xff40484c),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffdee3e6),
  inversePrimary: Color(0xff0c6780),
  primaryFixed: Color(0xffbaeaff),
  onPrimaryFixed: Color(0xff001f29),
  primaryFixedDim: Color(0xff89d0ed),
  onPrimaryFixedVariant: Color(0xff004d62),
  secondaryFixed: Color(0xffcfe6f1),
  onSecondaryFixed: Color(0xff071e26),
  secondaryFixedDim: Color(0xffb3cad5),
  onSecondaryFixedVariant: Color(0xff354a53),
  tertiaryFixed: Color(0xffe2dfff),
  onTertiaryFixed: Color(0xff181837),
  tertiaryFixedDim: Color(0xffc4c3eb),
  onTertiaryFixedVariant: Color(0xff444465),
  surfaceDim: Color(0xff0f1417),
  surfaceBright: Color(0xff353a3d),
  surfaceContainerLowest: Color(0xff0a0f11),
  surfaceContainerLow: Color(0xff171c1f),
  surfaceContainer: Color(0xff1b2023),
  surfaceContainerHigh: Color(0xff252b2d),
  surfaceContainerHighest: Color(0xff303638),
);

const kFreezeDrizzleCS = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff0c6780),
  surfaceTint: Color(0xff0c6780),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffbaeaff),
  onPrimaryContainer: Color(0xff001f29),
  secondary: Color(0xff4c626b),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffcfe6f1),
  onSecondaryContainer: Color(0xff071e26),
  tertiary: Color(0xff5b5b7e),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffe2dfff),
  onTertiaryContainer: Color(0xff181837),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  surface: Color(0xfff5fafd),
  onSurface: Color(0xff171c1f),
  onSurfaceVariant: Color(0xff40484c),
  outline: Color(0xff70787d),
  outlineVariant: Color(0xffc0c8cc),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2c3134),
  inversePrimary: Color(0xff89d0ed),
  primaryFixed: Color(0xffbaeaff),
  onPrimaryFixed: Color(0xff001f29),
  primaryFixedDim: Color(0xff89d0ed),
  onPrimaryFixedVariant: Color(0xff004d62),
  secondaryFixed: Color(0xffcfe6f1),
  onSecondaryFixed: Color(0xff071e26),
  secondaryFixedDim: Color(0xffb3cad5),
  onSecondaryFixedVariant: Color(0xff354a53),
  tertiaryFixed: Color(0xffe2dfff),
  onTertiaryFixed: Color(0xff181837),
  tertiaryFixedDim: Color(0xffc4c3eb),
  onTertiaryFixedVariant: Color(0xff444465),
  surfaceDim: Color(0xffd6dbde),
  surfaceBright: Color(0xfff5fafd),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xfff0f4f7),
  surfaceContainer: Color(0xffeaeef2),
  surfaceContainerHigh: Color(0xffe4e9ec),
  surfaceContainerHighest: Color(0xffdee3e6),
);

const kFreezeDrizzleDarkCS = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xff89d0ed),
  surfaceTint: Color(0xff89d0ed),
  onPrimary: Color(0xff003544),
  primaryContainer: Color(0xff004d62),
  onPrimaryContainer: Color(0xffbaeaff),
  secondary: Color(0xffb3cad5),
  onSecondary: Color(0xff1e333c),
  secondaryContainer: Color(0xff354a53),
  onSecondaryContainer: Color(0xffcfe6f1),
  tertiary: Color(0xffc4c3eb),
  onTertiary: Color(0xff2d2d4d),
  tertiaryContainer: Color(0xff444465),
  onTertiaryContainer: Color(0xffe2dfff),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffdad6),
  surface: Color(0xff0f1417),
  onSurface: Color(0xffdee3e6),
  onSurfaceVariant: Color(0xffc0c8cc),
  outline: Color(0xff8a9296),
  outlineVariant: Color(0xff40484c),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffdee3e6),
  inversePrimary: Color(0xff0c6780),
  primaryFixed: Color(0xffbaeaff),
  onPrimaryFixed: Color(0xff001f29),
  primaryFixedDim: Color(0xff89d0ed),
  onPrimaryFixedVariant: Color(0xff004d62),
  secondaryFixed: Color(0xffcfe6f1),
  onSecondaryFixed: Color(0xff071e26),
  secondaryFixedDim: Color(0xffb3cad5),
  onSecondaryFixedVariant: Color(0xff354a53),
  tertiaryFixed: Color(0xffe2dfff),
  onTertiaryFixed: Color(0xff181837),
  tertiaryFixedDim: Color(0xffc4c3eb),
  onTertiaryFixedVariant: Color(0xff444465),
  surfaceDim: Color(0xff0f1417),
  surfaceBright: Color(0xff353a3d),
  surfaceContainerLowest: Color(0xff0a0f11),
  surfaceContainerLow: Color(0xff171c1f),
  surfaceContainer: Color(0xff1b2023),
  surfaceContainerHigh: Color(0xff252b2d),
  surfaceContainerHighest: Color(0xff303638),
);

final kRainCS = ColorScheme.fromSeed(
  seedColor: Color(0xFFD8A07B),
  brightness: Brightness.light,
);

final kRainDarkCS = ColorScheme.fromSeed(
  seedColor: Color(0xFFD8A07B),
  brightness: Brightness.light,
);

const kFreezeRainCS = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff25686a),
  surfaceTint: Color(0xff25686a),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xff6cabad),
  onPrimaryContainer: Color(0xff001718),
  secondary: Color(0xff4c6363),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffd2ebeb),
  onSecondaryContainer: Color(0xff384e4f),
  tertiary: Color(0xff6a5582),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffae96c7),
  onTertiaryContainer: Color(0xff1c0932),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  surface: Color(0xfff8faf9),
  onSurface: Color(0xff191c1c),
  onSurfaceVariant: Color(0xff3f4849),
  outline: Color(0xff6f7979),
  outlineVariant: Color(0xffbfc8c8),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2e3131),
  inversePrimary: Color(0xff92d2d3),
  primaryFixed: Color(0xffaeeef0),
  onPrimaryFixed: Color(0xff002021),
  primaryFixedDim: Color(0xff92d2d3),
  onPrimaryFixedVariant: Color(0xff004f51),
  secondaryFixed: Color(0xffcee7e8),
  onSecondaryFixed: Color(0xff071f20),
  secondaryFixedDim: Color(0xffb3cbcc),
  onSecondaryFixedVariant: Color(0xff344b4b),
  tertiaryFixed: Color(0xffeedbff),
  onTertiaryFixed: Color(0xff25123a),
  tertiaryFixedDim: Color(0xffd6bdf0),
  onTertiaryFixedVariant: Color(0xff523e69),
  surfaceDim: Color(0xffd8dada),
  surfaceBright: Color(0xfff8faf9),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xfff2f4f3),
  surfaceContainer: Color(0xffeceeee),
  surfaceContainerHigh: Color(0xffe7e8e8),
  surfaceContainerHighest: Color(0xffe1e3e2),
);

const kFreezeRainDarkCS = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xff92d2d3),
  surfaceTint: Color(0xff92d2d3),
  onPrimary: Color(0xff003738),
  primaryContainer: Color(0xff3e7e80),
  onPrimaryContainer: Color(0xffffffff),
  secondary: Color(0xffb3cbcc),
  onSecondary: Color(0xff1e3435),
  secondaryContainer: Color(0xff2b4142),
  onSecondaryContainer: Color(0xffbdd6d7),
  tertiary: Color(0xffd6bdf0),
  onTertiary: Color(0xff3a2851),
  tertiaryContainer: Color(0xff816b99),
  onTertiaryContainer: Color(0xffffffff),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffdad6),
  surface: Color(0xff111414),
  onSurface: Color(0xffe1e3e2),
  onSurfaceVariant: Color(0xffbfc8c8),
  outline: Color(0xff899392),
  outlineVariant: Color(0xff3f4849),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe1e3e2),
  inversePrimary: Color(0xff25686a),
  primaryFixed: Color(0xffaeeef0),
  onPrimaryFixed: Color(0xff002021),
  primaryFixedDim: Color(0xff92d2d3),
  onPrimaryFixedVariant: Color(0xff004f51),
  secondaryFixed: Color(0xffcee7e8),
  onSecondaryFixed: Color(0xff071f20),
  secondaryFixedDim: Color(0xffb3cbcc),
  onSecondaryFixedVariant: Color(0xff344b4b),
  tertiaryFixed: Color(0xffeedbff),
  onTertiaryFixed: Color(0xff25123a),
  tertiaryFixedDim: Color(0xffd6bdf0),
  onTertiaryFixedVariant: Color(0xff523e69),
  surfaceDim: Color(0xff111414),
  surfaceBright: Color(0xff373a3a),
  surfaceContainerLowest: Color(0xff0b0f0f),
  surfaceContainerLow: Color(0xff191c1c),
  surfaceContainer: Color(0xff1d2020),
  surfaceContainerHigh: Color(0xff272b2b),
  surfaceContainerHighest: Color(0xff323535),
);

const kSnowCS = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff526162),
  surfaceTint: Color(0xff526162),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xfff1ffff),
  onPrimaryContainer: Color(0xff4a595a),
  secondary: Color(0xff5a5f5f),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffe2e8e7),
  onSecondaryContainer: Color(0xff464c4c),
  tertiary: Color(0xff5d5e62),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xfffcfbff),
  onTertiaryContainer: Color(0xff55565a),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  surface: Color(0xfffbf9f8),
  onSurface: Color(0xff1b1c1c),
  onSurfaceVariant: Color(0xff424848),
  outline: Color(0xff737878),
  outlineVariant: Color(0xffc2c7c7),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff303030),
  inversePrimary: Color(0xffb9caca),
  primaryFixed: Color(0xffd5e6e6),
  onPrimaryFixed: Color(0xff0f1e1e),
  primaryFixedDim: Color(0xffb9caca),
  onPrimaryFixedVariant: Color(0xff3a4a4a),
  secondaryFixed: Color(0xffdee4e3),
  onSecondaryFixed: Color(0xff171d1d),
  secondaryFixedDim: Color(0xffc2c8c7),
  onSecondaryFixedVariant: Color(0xff424848),
  tertiaryFixed: Color(0xffe3e2e6),
  onTertiaryFixed: Color(0xff1a1c1e),
  tertiaryFixedDim: Color(0xffc6c6ca),
  onTertiaryFixedVariant: Color(0xff46474a),
  surfaceDim: Color(0xffdbdad9),
  surfaceBright: Color(0xfffbf9f8),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xfff5f3f2),
  surfaceContainer: Color(0xffefeded),
  surfaceContainerHigh: Color(0xffeae8e7),
  surfaceContainerHighest: Color(0xffe4e2e1),
);

const kSnowDarkCS = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffffffff),
  surfaceTint: Color(0xffb9caca),
  onPrimary: Color(0xff243333),
  primaryContainer: Color(0xffc7d8d8),
  onPrimaryContainer: Color(0xff334242),
  secondary: Color(0xffc2c8c7),
  onSecondary: Color(0xff2c3132),
  secondaryContainer: Color(0xff383e3e),
  onSecondaryContainer: Color(0xffccd2d1),
  tertiary: Color(0xffffffff),
  onTertiary: Color(0xff2f3033),
  tertiaryContainer: Color(0xffd4d4d8),
  onTertiaryContainer: Color(0xff3e3f42),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffdad6),
  surface: Color(0xff131313),
  onSurface: Color(0xffe4e2e1),
  onSurfaceVariant: Color(0xffc2c7c7),
  outline: Color(0xff8c9292),
  outlineVariant: Color(0xff424848),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe4e2e1),
  inversePrimary: Color(0xff526162),
  primaryFixed: Color(0xffd5e6e6),
  onPrimaryFixed: Color(0xff0f1e1e),
  primaryFixedDim: Color(0xffb9caca),
  onPrimaryFixedVariant: Color(0xff3a4a4a),
  secondaryFixed: Color(0xffdee4e3),
  onSecondaryFixed: Color(0xff171d1d),
  secondaryFixedDim: Color(0xffc2c8c7),
  onSecondaryFixedVariant: Color(0xff424848),
  tertiaryFixed: Color(0xffe3e2e6),
  onTertiaryFixed: Color(0xff1a1c1e),
  tertiaryFixedDim: Color(0xffc6c6ca),
  onTertiaryFixedVariant: Color(0xff46474a),
  surfaceDim: Color(0xff131313),
  surfaceBright: Color(0xff393939),
  surfaceContainerLowest: Color(0xff0e0e0e),
  surfaceContainerLow: Color(0xff1b1c1c),
  surfaceContainer: Color(0xff1f2020),
  surfaceContainerHigh: Color(0xff2a2a2a),
  surfaceContainerHighest: Color(0xff343535),
);

const kRainShowerCS = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff005096),
  surfaceTint: Color(0xff005faf),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xff0075d6),
  onPrimaryContainer: Color(0xffffffff),
  secondary: Color(0xff415f8a),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffbcd5ff),
  onSecondaryContainer: Color(0xff1f4069),
  tertiary: Color(0xff7c259b),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffa54fc3),
  onTertiaryContainer: Color(0xffffffff),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  surface: Color(0xfff9f9ff),
  onSurface: Color(0xff181c22),
  onSurfaceVariant: Color(0xff404753),
  outline: Color(0xff707785),
  outlineVariant: Color(0xffc0c7d6),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2d3138),
  inversePrimary: Color(0xffa5c8ff),
  primaryFixed: Color(0xffd4e3ff),
  onPrimaryFixed: Color(0xff001c3a),
  primaryFixedDim: Color(0xffa5c8ff),
  onPrimaryFixedVariant: Color(0xff004786),
  secondaryFixed: Color(0xffd4e3ff),
  onSecondaryFixed: Color(0xff001c3a),
  secondaryFixedDim: Color(0xffaac8f9),
  onSecondaryFixedVariant: Color(0xff284871),
  tertiaryFixed: Color(0xfffad7ff),
  onTertiaryFixed: Color(0xff330045),
  tertiaryFixedDim: Color(0xffeeb0ff),
  onTertiaryFixedVariant: Color(0xff711891),
  surfaceDim: Color(0xffd7dae3),
  surfaceBright: Color(0xfff9f9ff),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xfff1f3fd),
  surfaceContainer: Color(0xffebeef7),
  surfaceContainerHigh: Color(0xffe5e8f1),
  surfaceContainerHighest: Color(0xffe0e2ec),
);

const kRainShowerDarkCS = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffa5c8ff),
  surfaceTint: Color(0xffa5c8ff),
  onPrimary: Color(0xff00315f),
  primaryContainer: Color(0xff0075d6),
  onPrimaryContainer: Color(0xffffffff),
  secondary: Color(0xffaac8f9),
  onSecondary: Color(0xff0c3159),
  secondaryContainer: Color(0xff204069),
  onSecondaryContainer: Color(0xffbdd5ff),
  tertiary: Color(0xffeeb0ff),
  onTertiary: Color(0xff53006f),
  tertiaryContainer: Color(0xffa54fc3),
  onTertiaryContainer: Color(0xffffffff),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffdad6),
  surface: Color(0xff10141a),
  onSurface: Color(0xffe0e2ec),
  onSurfaceVariant: Color(0xffc0c7d6),
  outline: Color(0xff8a919f),
  outlineVariant: Color(0xff404753),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe0e2ec),
  inversePrimary: Color(0xff005faf),
  primaryFixed: Color(0xffd4e3ff),
  onPrimaryFixed: Color(0xff001c3a),
  primaryFixedDim: Color(0xffa5c8ff),
  onPrimaryFixedVariant: Color(0xff004786),
  secondaryFixed: Color(0xffd4e3ff),
  onSecondaryFixed: Color(0xff001c3a),
  secondaryFixedDim: Color(0xffaac8f9),
  onSecondaryFixedVariant: Color(0xff284871),
  tertiaryFixed: Color(0xfffad7ff),
  onTertiaryFixed: Color(0xff330045),
  tertiaryFixedDim: Color(0xffeeb0ff),
  onTertiaryFixedVariant: Color(0xff711891),
  surfaceDim: Color(0xff10141a),
  surfaceBright: Color(0xff353941),
  surfaceContainerLowest: Color(0xff0a0e15),
  surfaceContainerLow: Color(0xff181c22),
  surfaceContainer: Color(0xff1c2027),
  surfaceContainerHigh: Color(0xff262a31),
  surfaceContainerHighest: Color(0xff31353c),
);

const kSnowShowerCS = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff3a6470),
  surfaceTint: Color(0xff3a6470),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffb3deec),
  onPrimaryContainer: Color(0xff1a4652),
  secondary: Color(0xff516166),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffd6e6ec),
  onSecondaryContainer: Color(0xff3c4b50),
  tertiary: Color(0xff6a5779),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffe6cef6),
  onTertiaryContainer: Color(0xff4b3a5a),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  surface: Color(0xfff9f9fa),
  onSurface: Color(0xff1a1c1d),
  onSurfaceVariant: Color(0xff41484a),
  outline: Color(0xff71787b),
  outlineVariant: Color(0xffc0c8cb),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2f3131),
  inversePrimary: Color(0xffa3cddb),
  primaryFixed: Color(0xffbeeaf8),
  onPrimaryFixed: Color(0xff001f27),
  primaryFixedDim: Color(0xffa3cddb),
  onPrimaryFixedVariant: Color(0xff214c58),
  secondaryFixed: Color(0xffd5e5eb),
  onSecondaryFixed: Color(0xff0e1e22),
  secondaryFixedDim: Color(0xffb9c9cf),
  onSecondaryFixedVariant: Color(0xff3a494e),
  tertiaryFixed: Color(0xfff1daff),
  onTertiaryFixed: Color(0xff241432),
  tertiaryFixedDim: Color(0xffd5bee5),
  onTertiaryFixedVariant: Color(0xff514060),
  surfaceDim: Color(0xffd9dadb),
  surfaceBright: Color(0xfff9f9fa),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xfff3f3f4),
  surfaceContainer: Color(0xffeeeeee),
  surfaceContainerHigh: Color(0xffe8e8e9),
  surfaceContainerHighest: Color(0xffe2e2e3),
);

const kSnowShowerDarkCS = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffebfaff),
  surfaceTint: Color(0xffa3cddb),
  onPrimary: Color(0xff023641),
  primaryContainer: Color(0xffa9d4e2),
  onPrimaryContainer: Color(0xff11404b),
  secondary: Color(0xffb9c9cf),
  onSecondary: Color(0xff243337),
  secondaryContainer: Color(0xff324146),
  onSecondaryContainer: Color(0xffc6d7dc),
  tertiary: Color(0xfffef4ff),
  onTertiary: Color(0xff3a2948),
  tertiaryContainer: Color(0xffdcc4ec),
  onTertiaryContainer: Color(0xff453353),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffdad6),
  surface: Color(0xff121414),
  onSurface: Color(0xffe2e2e3),
  onSurfaceVariant: Color(0xffc0c8cb),
  outline: Color(0xff8b9295),
  outlineVariant: Color(0xff41484a),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe2e2e3),
  inversePrimary: Color(0xff3a6470),
  primaryFixed: Color(0xffbeeaf8),
  onPrimaryFixed: Color(0xff001f27),
  primaryFixedDim: Color(0xffa3cddb),
  onPrimaryFixedVariant: Color(0xff214c58),
  secondaryFixed: Color(0xffd5e5eb),
  onSecondaryFixed: Color(0xff0e1e22),
  secondaryFixedDim: Color(0xffb9c9cf),
  onSecondaryFixedVariant: Color(0xff3a494e),
  tertiaryFixed: Color(0xfff1daff),
  onTertiaryFixed: Color(0xff241432),
  tertiaryFixedDim: Color(0xffd5bee5),
  onTertiaryFixedVariant: Color(0xff514060),
  surfaceDim: Color(0xff121414),
  surfaceBright: Color(0xff37393a),
  surfaceContainerLowest: Color(0xff0c0f0f),
  surfaceContainerLow: Color(0xff1a1c1d),
  surfaceContainer: Color(0xff1e2021),
  surfaceContainerHigh: Color(0xff282a2b),
  surfaceContainerHighest: Color(0xff333536),
);

const kThunderstormCS = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff342876),
  surfaceTint: Color(0xff5e53a3),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xff574d9c),
  onPrimaryContainer: Color(0xfffffdff),
  secondary: Color(0xff5f5a7b),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffe4ddff),
  onSecondaryContainer: Color(0xff484363),
  tertiary: Color(0xff5c1a50),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xff853e75),
  onTertiaryContainer: Color(0xfffffdff),
  error: Color(0xffba1a1a),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffffdad6),
  onErrorContainer: Color(0xff410002),
  surface: Color(0xfffdf8ff),
  onSurface: Color(0xff1c1b20),
  onSurfaceVariant: Color(0xff484551),
  outline: Color(0xff787582),
  outlineVariant: Color(0xffc9c4d2),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff313035),
  inversePrimary: Color(0xffc8bfff),
  primaryFixed: Color(0xffe5deff),
  onPrimaryFixed: Color(0xff1a065c),
  primaryFixedDim: Color(0xffc8bfff),
  onPrimaryFixedVariant: Color(0xff463b89),
  secondaryFixed: Color(0xffe5deff),
  onSecondaryFixed: Color(0xff1b1834),
  secondaryFixedDim: Color(0xffc8c2e8),
  onSecondaryFixedVariant: Color(0xff474362),
  tertiaryFixed: Color(0xffffd7f0),
  onTertiaryFixed: Color(0xff3a0032),
  tertiaryFixedDim: Color(0xfffface7),
  onTertiaryFixedVariant: Color(0xff702d63),
  surfaceDim: Color(0xffddd8e0),
  surfaceBright: Color(0xfffdf8ff),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xfff7f2fa),
  surfaceContainer: Color(0xfff1ecf4),
  surfaceContainerHigh: Color(0xffebe6ee),
  surfaceContainerHighest: Color(0xffe5e1e8),
);

const kThunderstormDarkCS = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffc8bfff),
  surfaceTint: Color(0xffc8bfff),
  onPrimary: Color(0xff2f2371),
  primaryContainer: Color(0xff3e3381),
  onPrimaryContainer: Color(0xffd6ceff),
  secondary: Color(0xffc8c2e8),
  onSecondary: Color(0xff312d4b),
  secondaryContainer: Color(0xff403b5a),
  onSecondaryContainer: Color(0xffd6cff6),
  tertiary: Color(0xfffface7),
  onTertiary: Color(0xff56154b),
  tertiaryContainer: Color(0xff68265b),
  onTertiaryContainer: Color(0xffffc3eb),
  error: Color(0xffffb4ab),
  onError: Color(0xff690005),
  errorContainer: Color(0xff93000a),
  onErrorContainer: Color(0xffffdad6),
  surface: Color(0xff141318),
  onSurface: Color(0xffe5e1e8),
  onSurfaceVariant: Color(0xffc9c4d2),
  outline: Color(0xff928f9c),
  outlineVariant: Color(0xff484551),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe5e1e8),
  inversePrimary: Color(0xff5e53a3),
  primaryFixed: Color(0xffe5deff),
  onPrimaryFixed: Color(0xff1a065c),
  primaryFixedDim: Color(0xffc8bfff),
  onPrimaryFixedVariant: Color(0xff463b89),
  secondaryFixed: Color(0xffe5deff),
  onSecondaryFixed: Color(0xff1b1834),
  secondaryFixedDim: Color(0xffc8c2e8),
  onSecondaryFixedVariant: Color(0xff474362),
  tertiaryFixed: Color(0xffffd7f0),
  onTertiaryFixed: Color(0xff3a0032),
  tertiaryFixedDim: Color(0xfffface7),
  onTertiaryFixedVariant: Color(0xff702d63),
  surfaceDim: Color(0xff141318),
  surfaceBright: Color(0xff3a383e),
  surfaceContainerLowest: Color(0xff0e0e13),
  surfaceContainerLow: Color(0xff1c1b20),
  surfaceContainer: Color(0xff201f24),
  surfaceContainerHigh: Color(0xff2b292f),
  surfaceContainerHighest: Color(0xff35343a),
);

const kCityTextStyle = TextStyle(
  fontFamily: "Quicksand",
  fontSize: 40,
  fontWeight: FontWeight.w500,
);

const kDateTextStyle = TextStyle(
  fontFamily: "Quicksand",
  fontSize: 18,
);

const kConditionTextStyle = TextStyle(
  fontFamily: "Noto Sans",
  fontSize: 24,
);

const kDetailHeaderTextStyle = TextStyle(
  fontFamily: "Noto Sans",
  fontSize: 14,
);

const kDetailValueTextStyle = TextStyle(
  fontFamily: "Noto Sans",
  fontSize: 16,
);
const kWeatherForecastTextStyle = TextStyle(
  fontFamily: "Quicksand",
  fontSize: 18,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);

const kForecastTitleTextStyle = TextStyle(
  fontFamily: "Quicksand",
  fontWeight: FontWeight.bold,
  fontSize: 24,
);

const kSearchCityTextStyle = TextStyle(
  fontFamily: "Noto Sans",
  fontSize: 20,
);
