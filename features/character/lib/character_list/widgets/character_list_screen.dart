import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../character.dart';
import '../bloc/character_list_bloc.dart';
import 'character_list_tile.dart';

@RoutePage()
class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CharacterListBloc(appLocator.get<GetCharacterListUseCase>())
            ..add(CharacterListEvent.fetch()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.character_characters.tr()),
        ),
        body: BlocBuilder<CharacterListBloc, CharacterListState>(
          builder: (context, state) {
            if (state.initial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status.isError) {
              return Container(
                padding: const EdgeInsets.all(AppDimens.PADDING_16),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppDimens.BORDER_RADIUS_20),
                  color: context.colorScheme.errorContainer,
                ),
                child: Text(
                  state.status.error!,
                  style: context.textTheme.labelMedium!
                      .copyWith(color: context.colorScheme.onError),
                ),
              );
            }
            return _ContentList(
              state.data,
              loadMore: () => context
                  .read<CharacterListBloc>()
                  .add(CharacterListEvent.fetch()),
              isLoading: state.status.isLoading,
              hasReachedMax: state.hasReachedMax,
            );
          },
        ),
      ),
    );
  }
}

class _ContentList extends StatefulWidget {
  const _ContentList(
    this.characters, {
    required this.loadMore,
    this.isLoading = true,
    this.hasReachedMax = false,
  });

  final List<Character> characters;
  final VoidCallback loadMore;
  final bool isLoading;
  final bool hasReachedMax;

  @override
  State<_ContentList> createState() => __ContentListState();
}

class __ContentListState extends State<_ContentList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    final shouldLoad = currentScroll >= (maxScroll * 0.9);

    if (shouldLoad && !widget.isLoading) {
      widget.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.PADDING_10,
          vertical: AppDimens.PADDING_10,
        ),
        itemBuilder: (context, index) => index >= widget.characters.length
            ? const Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(),
                ),
              )
            : CharacterListTile(
                key: ValueKey(widget.characters[index].id),
                widget.characters[index],
                onPressed: () =>
                    context.pushRoute(const CharacterDetailsRoute()),
              ),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemCount: widget.hasReachedMax
            ? widget.characters.length
            : widget.characters.length + 1,
      ),
    );
  }
}
