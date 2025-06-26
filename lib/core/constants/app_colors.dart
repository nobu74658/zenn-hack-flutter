import 'package:flutter/material.dart';

/// Application color constants
/// Based on the web frontend color palette from globals.css
class AppColors {
  // Private constructor to prevent instantiation
  const AppColors._();

  // ====================
  // Web Frontend Colors (from globals.css)
  // ====================

  /// Background Colors
  static const bgPrimary = Color(0xFFFFFDF6); // --bg-primary: #fffdf6
  static const bgSecondary = Color(0xFFFAF6E9); // --bg-secondary: #faf6e9
  static const bgWhole = Color(0xFFEAEFD2); // --bg-whole: #eaefd2

  /// Main Theme Colors
  static const colorMain = Color(0xFFA0C878); // --color-main: #a0c878
  static const colorSub = Color(0xFFDDEB9D); // --color-sub: #ddeb9d
  static const colorDarkGreen = Color(
    0xFF537945,
  ); // --color-dark-green: #537945

  /// Text Colors
  static const textMain = Color(0xFF302C53); // --color-text-main: #302c53
  static const textSub = Color(0xFF6B6A8E); // --color-text-sub: #6b6a8e

  /// Accent Colors
  static const colorRed = Color(0xFFC87A78); // --color-red: #c87a78
  static const colorBlue = Color(0xFF78A3C8); // --color-blue: #78a3c8

  // ====================
  // Flutter Material Colors
  // ====================

  /// Primary color scheme
  static const Color primary = colorMain;
  static const Color primaryVariant = colorDarkGreen;
  static const Color secondary = colorSub;

  /// Surface colors
  static const Color surface = Colors.white;
  static const Color background = bgPrimary;
  static const Color backgroundSecondary = bgSecondary;

  /// Text colors on different backgrounds
  static const Color onPrimary = Colors.white;
  static const Color onSecondary = textMain;
  static const Color onSurface = textMain;
  static const Color onBackground = textMain;

  /// Status colors
  static const Color success = colorMain;
  static const Color error = colorRed;
  static const warning = Color(0xFFFFB74D);
  static const Color info = colorBlue;

  // ====================
  // Part of Speech Colors (品詞別カラー)
  // ====================
  // WebフロントエンドのスクリーンショットやBadgeコンポーネントで使用されているカラーを参考に設定

  /// 名詞 (Noun)
  static const nounColor = Color(0xFFDDEB9D); // Light green (colorSub)

  /// 動詞 (Verb)
  static const verbColor = Color(0xFFFFFF99); // Light yellow

  /// 形容詞 (Adjective)
  static const adjectiveColor = Color(0xFF87CEEB); // Light blue (SkyBlue)

  /// 副詞 (Adverb)
  static const adverbColor = Color(0xFFDDA0DD); // Plum

  /// 前置詞 (Preposition)
  static const prepositionColor = Color(0xFFFFA07A); // Light salmon

  /// その他の品詞
  static const otherPosColor = Color(0xFFE6E6FA); // Lavender

  // ====================
  // Card & Component Colors
  // ====================

  /// Card styling
  static const Color cardBackground = surface;
  static const cardShadow = Color(0x1A000000); // 10% black shadow
  static const cardBorder = Color(0xFFE0E0E0);

  /// Button colors
  static const Color buttonPrimary = colorMain;
  static const Color buttonSecondary = colorSub;
  static const buttonDisabled = Color(0xFFBDBDBD);

  /// Input field colors
  static const inputBorder = Color(0xFFE0E0E0);
  static const Color inputFocusBorder = colorMain;
  static const Color inputFill = Colors.white;

  // ====================
  // Learning App Specific Colors
  // ====================

  /// Flashcard states
  static const Color cardLearned = success; // 学習済み
  static const Color cardNotLearned = error; // 未学習
  static const Color cardInProgress = warning; // 学習中

  /// Swipe feedback colors
  static const swipeRightFeedback = Color(0xFF4CAF50); // Green
  static const swipeLeftFeedback = Color(0xFFF44336); // Red

  // ====================
  // Helper Methods
  // ====================

  /// Get part of speech color by enum
  static Color getPartOfSpeechColor(String pos) {
    switch (pos.toLowerCase()) {
      case 'noun':
        return nounColor;
      case 'pronoun':
        return nounColor;
      case 'intransitiveverb':
      case 'transitiveverb':
      case 'auxiliaryverb':
        return verbColor;
      case 'adjective':
        return adjectiveColor;
      case 'adverb':
        return adverbColor;
      case 'preposition':
        return prepositionColor;
      case 'article':
      case 'interjection':
      case 'conjunction':
      case 'idiom':
      default:
        return otherPosColor;
    }
  }

  /// Get lighter variant of a color
  static Color getLighterVariant(Color color, [double factor = 0.3]) {
    return Color.lerp(color, Colors.white, factor) ?? color;
  }

  /// Get darker variant of a color
  static Color getDarkerVariant(Color color, [double factor = 0.3]) {
    return Color.lerp(color, Colors.black, factor) ?? color;
  }
}

/// Extension for easier color usage
extension AppColorExtension on Color {
  /// Create a MaterialColor from a single color
  MaterialColor get materialColor {
    final swatch = <int, Color>{};
    final r = this.r;
    final g = this.g;
    final b = this.b;

    for (var i = 1; i <= 9; i++) {
      final strength = i * 0.1;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        (r + ((255 - r) * strength)).round(),
        (g + ((255 - g) * strength)).round(),
        (b + ((255 - b) * strength)).round(),
        1,
      );
    }

    return MaterialColor(toARGB32(), swatch);
  }
}
