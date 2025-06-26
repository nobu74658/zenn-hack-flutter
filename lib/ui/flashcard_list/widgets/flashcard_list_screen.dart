import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_names.dart';
import '../../../domain/models/common/enums.dart';
import '../../../domain/models/flashcard_list/flashcard_list_state.dart';
import '../notifiers/flashcard_list_notifier.dart';
import './flashcard_item.dart';

class FlashcardListScreen extends ConsumerWidget {
  const FlashcardListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(flashcardListNotifierProvider);
    final notifier = ref.read(flashcardListNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('単語帳'),
        actions: [
          stateAsync.when(
            data:
                (state) => IconButton(
                  icon: Icon(
                    state.displayMode == DisplayMode.grid
                        ? Icons.list
                        : Icons.grid_view,
                  ),
                  onPressed: notifier.toggleDisplayMode,
                ),
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortOptions(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(ref),
          _buildFilterChips(ref),
          Expanded(
            child: stateAsync.when(
              data: (state) {
                if (state.flashcards.isEmpty) {
                  return const Center(child: Text('単語カードがありません'));
                }

                if (state.displayMode == DisplayMode.grid) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                    itemCount: state.flashcards.length,
                    itemBuilder: (context, index) {
                      final flashcard = state.flashcards[index];
                      return FlashcardItem(flashcard: flashcard);
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: state.flashcards.length,
                    itemBuilder: (context, index) {
                      final flashcard = state.flashcards[index];
                      return FlashcardItem(flashcard: flashcard);
                    },
                  );
                }
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('エラーが発生しました: $error')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(RouteNames.study),
        label: const Text('学習開始'),
        icon: const Icon(Icons.play_arrow),
      ),
    );
  }

  Widget _buildSearchBar(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        decoration: const InputDecoration(
          hintText: '単語・意味で検索',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: ref.read(flashcardListNotifierProvider.notifier).searchCards,
      ),
    );
  }

  Widget _buildFilterChips(WidgetRef ref) {
    final state = ref.watch(flashcardListNotifierProvider).asData?.value;
    if (state == null) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          ...PartOfSpeech.values.map((pos) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Text(pos.displayName),
                selected: state.posFilter == pos,
                onSelected: (selected) {
                  ref
                      .read(flashcardListNotifierProvider.notifier)
                      .filterByPos(selected ? pos : null);
                },
              ),
            );
          }),
          const VerticalDivider(),
          ...LearningStatus.values.map((status) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Text(status.displayName),
                selected: state.statusFilter == status,
                onSelected: (selected) {
                  ref
                      .read(flashcardListNotifierProvider.notifier)
                      .filterByStatus(selected ? status : null);
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  void _showSortOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        final notifier = ref.read(flashcardListNotifierProvider.notifier);
        return Wrap(
          children:
              SortOption.values.map((option) {
                return ListTile(
                  title: Text(option.displayName),
                  onTap: () {
                    notifier.sortCards(option);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
        );
      },
    );
  }
}
