import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_test/without_builder/common/widgets/bottom_tab_bar.dart';
import 'package:go_router_test/without_builder/common/widgets/suggestions_list.dart';
import 'package:go_router_test/without_builder/store/widgets/scrollable_sheet.dart';

import 'app_header.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final ValueNotifier showSuggestions = ValueNotifier<bool>(false);
  late final FocusNode searchFocusNode;

  @override
  void initState() {
    searchFocusNode = FocusNode()
      ..addListener(() {
        showSuggestions.value = searchFocusNode.hasFocus;
      });
    super.initState();
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSuggestionsScreen = GoRouter.of(context).location == "/suggestions";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppHeader(
        showBackButton: isSuggestionsScreen,
        autofocus: isSuggestionsScreen,
        searchFocusNode: searchFocusNode,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: widget.child,
          ),
          if (!isSuggestionsScreen)
            const Positioned(
              bottom: 0,
              top: 0,
              left: 20,
              right: 20,
              child: DraggableScrollableStoreSheet(),
            ),
          if (!isSuggestionsScreen)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomTabBar(),
            ),
          ValueListenableBuilder(
            valueListenable: showSuggestions,
            builder: (_, value, child) {
              return value ? child! : Container();
            },
            child: const SearchSuggestionsList(),
          ),
        ],
      ),
    );
  }
}
