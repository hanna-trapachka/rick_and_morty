import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../core_ui.dart';

class InfiniteList extends StatefulWidget {
  const InfiniteList({
    required this.itemBuilder,
    required this.itemsCount,
    this.loadMore,
    this.isLoading = true,
    this.hasReachedMax = false,
    this.error,
  });

  final int itemsCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final VoidCallback? loadMore;
  final bool isLoading;
  final bool hasReachedMax;
  final String? error;

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

    final shouldFetch =
        currentScroll >= (maxScroll * 0.9) && !widget.hasReachedMax;

    if (shouldFetch && !widget.isLoading) {
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
            ? _ListFooterItem(
                onRetryPressed: widget.loadMore,
                error: widget.error,
                isLoading: widget.isLoading,
              )
            : widget.itemBuilder(context, index),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemCount:
            widget.hasReachedMax ? widget.itemsCount : widget.itemsCount + 1,
      ),
    );
  }
}

class _ListFooterItem extends StatelessWidget {
  const _ListFooterItem({
    required this.isLoading,
    this.onRetryPressed,
    this.error,
  });

  final VoidCallback? onRetryPressed;
  final String? error;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: BlocConsumer<ConnectivityBloc, ConnectivityState>(
        listener: (context, state) => onRetryPressed?.call(),
        listenWhen: (previous, current) =>
            previous is ConnectivityFailure && current is ConnectivitySuccess,
        builder: (context, state) {
          if (isLoading) {
            return const Center(child: AppLoadingAnimation(size: 40));
          }
          if (state is ConnectivityFailure) {
            return Center(
              child: RetryErrorWidget(
                text: LocaleKeys.general_check_connectivity.tr(),
                onTryAgainPressed: onRetryPressed,
              ),
            );
          }
          if (error != null) {
            return Center(
              child: RetryErrorWidget(onTryAgainPressed: onRetryPressed),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
