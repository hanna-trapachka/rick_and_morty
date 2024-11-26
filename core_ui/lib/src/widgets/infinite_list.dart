import 'package:flutter/material.dart';

import '../../core_ui.dart';

class InfiniteList extends StatefulWidget {
  const InfiniteList({
    required this.itemBuilder,
    required this.itemsCount,
    this.loadMore,
    this.isLoading = true,
    this.hasReachedMax = false,
  });

  final int itemsCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final VoidCallback? loadMore;
  final bool isLoading;
  final bool hasReachedMax;

  @override
  State<InfiniteList> createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
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
      widget.loadMore?.call();
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
        itemBuilder: (context, index) => index >= widget.itemsCount
            ? const Center(child: AppLoadingAnimation(size: 40))
            : widget.itemBuilder(context, index),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemCount:
            widget.hasReachedMax ? widget.itemsCount : widget.itemsCount + 1,
      ),
    );
  }
}
