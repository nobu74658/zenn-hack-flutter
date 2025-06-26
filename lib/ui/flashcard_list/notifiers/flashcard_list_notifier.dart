import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/result.dart';
import '../../../data/repositories/providers.dart';
import '../../../domain/models/common/enums.dart';
import '../../../domain/models/flashcard/flashcard.dart';
import '../../../domain/models/flashcard_list/flashcard_list_state.dart';

part 'flashcard_list_notifier.g.dart';

@riverpod
class FlashcardListNotifier extends _$FlashcardListNotifier {
  @override
  FutureOr<FlashcardListState> build() async {
    // TODO(you): Get userId from auth service
    const userId = '1';
    final result =
        await ref.read(flashcardRepositoryProvider).getUserFlashcards(userId);

    switch (result) {
      case Ok(data: final flashcards):
        return FlashcardListState(
          originalFlashcards: flashcards,
          flashcards: flashcards,
          isLoading: false,
        );
      case Error(exception: final error):
        return FlashcardListState(error: error, isLoading: false);
    }
  }

  void searchCards(String query) {
    final currentState = state.asData!.value;
    state = AsyncData(currentState.copyWith(searchQuery: query));
    _applyFilters();
  }

  void filterByPos(PartOfSpeech? pos) {
    final currentState = state.asData!.value;
    state = AsyncData(currentState.copyWith(posFilter: pos));
    _applyFilters();
  }

  void filterByStatus(LearningStatus? status) {
    final currentState = state.asData!.value;
    state = AsyncData(currentState.copyWith(statusFilter: status));
    _applyFilters();
  }

  void sortCards(SortOption option) {
    final currentState = state.asData!.value;
    var isAscending = currentState.isAscending;
    // If the same option is selected, toggle the order
    if (currentState.sortOption == option) {
      isAscending = !isAscending;
    } else {
      isAscending = true; // Default to ascending for new option
    }
    state = AsyncData(
      currentState.copyWith(sortOption: option, isAscending: isAscending),
    );
    _applyFilters();
  }

  void _applyFilters() {
    final currentState = state.asData!.value;
    var filteredList = List<Flashcard>.from(currentState.originalFlashcards);

    // Search Query Filter
    final searchQuery = currentState.searchQuery.toLowerCase();
    if (searchQuery.isNotEmpty) {
      filteredList =
          filteredList.where((card) {
            final word = card.word.word.toLowerCase();
            final meaning = card.meanings
                .map((m) => m.translation.toLowerCase())
                .join(' ');
            return word.contains(searchQuery) || meaning.contains(searchQuery);
          }).toList();
    }

    // Part of Speech Filter
    if (currentState.posFilter != null) {
      filteredList =
          filteredList.where((card) {
            return card.meanings.any((m) => m.pos == currentState.posFilter);
          }).toList();
    }

    // Learning Status Filter
    if (currentState.statusFilter != null) {
      filteredList =
          filteredList.where((card) {
            final status = currentState.statusFilter!;
            switch (status) {
              case LearningStatus.mastered:
                return card.checkFlag;
              case LearningStatus.notStudied:
              case LearningStatus.learning:
                return !card.checkFlag;
            }
          }).toList();
    }

    // Sorting
    final sortOption = currentState.sortOption;
    final isAscending = currentState.isAscending;

    filteredList.sort((a, b) {
      int comparison;
      switch (sortOption) {
        case SortOption.alphabetical:
          comparison = a.word.word.compareTo(b.word.word);
        case SortOption.status:
          comparison = (a.checkFlag ? 1 : 0).compareTo(b.checkFlag ? 1 : 0);
        case SortOption.dateAdded:
          comparison = a.createdAt.compareTo(b.createdAt);
      }
      return isAscending ? comparison : -comparison;
    });

    state = AsyncData(currentState.copyWith(flashcards: filteredList));
  }

  void toggleDisplayMode() {
    final currentMode = state.asData!.value.displayMode;
    final newMode =
        currentMode == DisplayMode.grid ? DisplayMode.list : DisplayMode.grid;
    state = AsyncData(state.asData!.value.copyWith(displayMode: newMode));
  }
}
