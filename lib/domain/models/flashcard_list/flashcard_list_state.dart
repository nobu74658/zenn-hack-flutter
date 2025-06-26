import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gen_flash_english_study/domain/models/common/enums.dart';
import 'package:gen_flash_english_study/domain/models/flashcard/flashcard.dart';

part 'flashcard_list_state.freezed.dart';

enum DisplayMode { grid, list }

enum SortOption { alphabetical, dateAdded, status }

extension SortOptionExtension on SortOption {
  String get displayName {
    switch (this) {
      case SortOption.alphabetical:
        return 'アルファベット順';
      case SortOption.dateAdded:
        return '追加日順';
      case SortOption.status:
        return '学習状態順';
    }
  }
}

@freezed
class FlashcardListState with _$FlashcardListState {
  const factory FlashcardListState({
    @Default([]) List<Flashcard> flashcards,
    @Default([]) List<Flashcard> originalFlashcards,
    @Default(true) bool isLoading,
    Object? error,
    @Default(DisplayMode.grid) DisplayMode displayMode,
    @Default('') String searchQuery,
    PartOfSpeech? posFilter,
    LearningStatus? statusFilter,
    @Default(SortOption.dateAdded) SortOption sortOption,
    @Default(true) bool isAscending,
  }) = _FlashcardListState;
}
