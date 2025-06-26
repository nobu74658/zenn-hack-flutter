import 'package:freezed_annotation/freezed_annotation.dart';

/// Learning status for flashcards
enum LearningStatus {
  /// Not yet studied
  notStudied,

  /// Currently learning
  learning,

  /// Mastered
  mastered,
}

extension LearningStatusExtension on LearningStatus {
  String get displayName {
    switch (this) {
      case LearningStatus.notStudied:
        return '未学習';
      case LearningStatus.learning:
        return '学習中';
      case LearningStatus.mastered:
        return '学習済み';
    }
  }
}

/// Part of speech types - aligned with frontend
enum PartOfSpeech {
  @JsonValue('noun')
  noun,
  @JsonValue('pronoun')
  pronoun,
  @JsonValue('intransitiveVerb')
  intransitiveVerb,
  @JsonValue('transitiveVerb')
  transitiveVerb,
  @JsonValue('adjective')
  adjective,
  @JsonValue('adverb')
  adverb,
  @JsonValue('auxiliaryVerb')
  auxiliaryVerb,
  @JsonValue('preposition')
  preposition,
  @JsonValue('article')
  article,
  @JsonValue('interjection')
  interjection,
  @JsonValue('conjunction')
  conjunction,
  @JsonValue('idiom')
  idiom,
}

/// Extension to provide display strings for PartOfSpeech
extension PartOfSpeechExtension on PartOfSpeech {
  /// Human-readable display name
  String get displayName {
    switch (this) {
      case PartOfSpeech.noun:
        return '名詞';
      case PartOfSpeech.pronoun:
        return '代名詞';
      case PartOfSpeech.intransitiveVerb:
        return '自動詞';
      case PartOfSpeech.transitiveVerb:
        return '他動詞';
      case PartOfSpeech.adjective:
        return '形容詞';
      case PartOfSpeech.adverb:
        return '副詞';
      case PartOfSpeech.auxiliaryVerb:
        return '助動詞';
      case PartOfSpeech.preposition:
        return '前置詞';
      case PartOfSpeech.article:
        return '冠詞';
      case PartOfSpeech.interjection:
        return '感嘆詞';
      case PartOfSpeech.conjunction:
        return '接続詞';
      case PartOfSpeech.idiom:
        return 'イディオム';
    }
  }

  /// API string representation
  String get apiValue {
    switch (this) {
      case PartOfSpeech.noun:
        return 'noun';
      case PartOfSpeech.pronoun:
        return 'pronoun';
      case PartOfSpeech.intransitiveVerb:
        return 'intransitiveVerb';
      case PartOfSpeech.transitiveVerb:
        return 'transitiveVerb';
      case PartOfSpeech.adjective:
        return 'adjective';
      case PartOfSpeech.adverb:
        return 'adverb';
      case PartOfSpeech.auxiliaryVerb:
        return 'auxiliaryVerb';
      case PartOfSpeech.preposition:
        return 'preposition';
      case PartOfSpeech.article:
        return 'article';
      case PartOfSpeech.interjection:
        return 'interjection';
      case PartOfSpeech.conjunction:
        return 'conjunction';
      case PartOfSpeech.idiom:
        return 'idiom';
    }
  }

  /// Parse from API string
  static PartOfSpeech fromApiValue(String value) {
    switch (value.toLowerCase()) {
      case 'noun':
        return PartOfSpeech.noun;
      case 'pronoun':
        return PartOfSpeech.pronoun;
      case 'intransitiveverb':
        return PartOfSpeech.intransitiveVerb;
      case 'transitiveverb':
        return PartOfSpeech.transitiveVerb;
      case 'adjective':
        return PartOfSpeech.adjective;
      case 'adverb':
        return PartOfSpeech.adverb;
      case 'auxiliaryverb':
        return PartOfSpeech.auxiliaryVerb;
      case 'preposition':
        return PartOfSpeech.preposition;
      case 'article':
        return PartOfSpeech.article;
      case 'interjection':
        return PartOfSpeech.interjection;
      case 'conjunction':
        return PartOfSpeech.conjunction;
      case 'idiom':
        return PartOfSpeech.idiom;
      default:
        return PartOfSpeech.noun; // Default to noun if unknown
    }
  }
}

/// Swipe direction for card interactions
enum SwipeDirection { left, right, up, down }

/// Media generation types
enum MediaGenerationType { textToImage, imageToImage, textToVideo }

/// Extension for MediaGenerationType
extension MediaGenerationTypeExtension on MediaGenerationType {
  /// API string representation
  String get apiValue {
    switch (this) {
      case MediaGenerationType.textToImage:
        return 'text-to-image';
      case MediaGenerationType.imageToImage:
        return 'image-to-image';
      case MediaGenerationType.textToVideo:
        return 'text-to-video';
    }
  }

  /// Display name
  String get displayName {
    switch (this) {
      case MediaGenerationType.textToImage:
        return 'テキストから画像';
      case MediaGenerationType.imageToImage:
        return '画像から画像';
      case MediaGenerationType.textToVideo:
        return 'テキストから動画';
    }
  }
}
