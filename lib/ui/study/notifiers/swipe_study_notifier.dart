import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/result.dart';
import '../../../data/repositories/providers.dart';
import '../../../domain/models/flashcard/flashcard.dart';

part 'swipe_study_notifier.g.dart';

/// State for swipe study session
class SwipeStudyState {
  const SwipeStudyState({
    required this.flashcards,
    required this.currentIndex,
    required this.isCardFlipped,
    required this.isLoading,
    this.error,
  });

  /// List of flashcards for the current study session
  final List<Flashcard> flashcards;

  /// Current card index
  final int currentIndex;

  /// Whether the current card is flipped to show meaning
  final bool isCardFlipped;

  /// Whether data is being loaded
  final bool isLoading;

  /// Error message if any
  final String? error;

  /// Get current flashcard
  Flashcard? get currentCard =>
      flashcards.isNotEmpty && currentIndex < flashcards.length
          ? flashcards[currentIndex]
          : null;

  /// Get next flashcard for preview
  Flashcard? get nextCard =>
      flashcards.isNotEmpty && currentIndex + 1 < flashcards.length
          ? flashcards[currentIndex + 1]
          : null;

  /// Get the flashcard after next for stack preview
  Flashcard? get thirdCard =>
      flashcards.isNotEmpty && currentIndex + 2 < flashcards.length
          ? flashcards[currentIndex + 2]
          : null;

  /// Check if there are more cards
  bool get hasMoreCards => currentIndex < flashcards.length - 1;

  /// Get current progress (1-based)
  int get currentProgress => currentIndex + 1;

  /// Get total cards count
  int get totalCards => flashcards.length;

  /// Check if study session is completed
  bool get isCompleted => currentIndex >= flashcards.length;

  SwipeStudyState copyWith({
    List<Flashcard>? flashcards,
    int? currentIndex,
    bool? isCardFlipped,
    bool? isLoading,
    String? error,
  }) {
    return SwipeStudyState(
      flashcards: flashcards ?? this.flashcards,
      currentIndex: currentIndex ?? this.currentIndex,
      isCardFlipped: isCardFlipped ?? this.isCardFlipped,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

@riverpod
class SwipeStudyNotifier extends _$SwipeStudyNotifier {
  @override
  Future<SwipeStudyState> build() async {
    try {
      // Get flashcard repository
      final repository = ref.read(flashcardRepositoryProvider);

      // Fetch flashcards for the current user
      // For demo purposes, using a mock user ID
      final result = await repository.getUserFlashcards('demo_user');

      switch (result) {
        case Ok(:final data):
          return SwipeStudyState(
            flashcards: data,
            currentIndex: 0,
            isCardFlipped: false,
            isLoading: false,
          );
        case Error(:final exception):
          return SwipeStudyState(
            flashcards: const [],
            currentIndex: 0,
            isCardFlipped: false,
            isLoading: false,
            error: exception.toString(),
          );
      }
    } on Exception catch (e) {
      return SwipeStudyState(
        flashcards: const [],
        currentIndex: 0,
        isCardFlipped: false,
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Handle left swipe (not learned)
  void onSwipeLeft() {
    final currentState = state.value;
    if (currentState == null || currentState.isCompleted) {
      return;
    }

    // Provide haptic feedback
    HapticFeedback.lightImpact();

    // Move to next card (read-only operation, no data update)
    _moveToNextCard();
  }

  /// Handle right swipe (learned)
  void onSwipeRight() {
    final currentState = state.value;
    if (currentState == null || currentState.isCompleted) {
      return;
    }

    // Provide haptic feedback
    HapticFeedback.lightImpact();

    // Move to next card (read-only operation, no data update)
    _moveToNextCard();
  }

  /// Handle card flip (show meaning)
  void flipCard() {
    final currentState = state.value;
    if (currentState == null) {
      return;
    }

    // Provide light haptic feedback
    HapticFeedback.selectionClick();

    state = AsyncValue.data(
      currentState.copyWith(isCardFlipped: !currentState.isCardFlipped),
    );
  }

  /// Skip current card
  void skipCard() {
    final currentState = state.value;
    if (currentState == null || currentState.isCompleted) {
      return;
    }

    // Provide haptic feedback
    HapticFeedback.selectionClick();

    _moveToNextCard();
  }

  /// Move to next card
  void _moveToNextCard() {
    final currentState = state.value;
    if (currentState == null) {
      return;
    }

    state = AsyncValue.data(
      currentState.copyWith(
        currentIndex: currentState.currentIndex + 1,
        isCardFlipped: false, // Reset flip state for new card
      ),
    );
  }

  /// Reset study session
  void resetSession() {
    final currentState = state.value;
    if (currentState == null) {
      return;
    }

    state = AsyncValue.data(
      currentState.copyWith(currentIndex: 0, isCardFlipped: false),
    );
  }

  /// Show hint for current card
  void showHint() {
    final currentState = state.value;
    if (currentState == null) {
      return;
    }

    // For now, just flip the card to show meaning
    if (!currentState.isCardFlipped) {
      flipCard();
    }
  }
}
