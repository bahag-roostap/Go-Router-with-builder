import 'dart:ui';

import 'package:custom_widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final bool showProfileButton;
  final bool showBackButton;
  final bool autofocus;
  final String? title;
  final double borderHeight;
  final FocusNode? searchFocusNode;

  const AppHeader({
    super.key,
    this.title,
    this.searchFocusNode,
    this.autofocus = false,
    this.showBackButton = false,
    this.showProfileButton = true,
    this.borderHeight = 40,
  });

  // If we ever want a specific size for our app header we need to set the `toolbarHeight`
  // property in both AppBar constructors. Some for the `bottom` property.
  @override
  Size get preferredSize => Size(AppBar().preferredSize.width, 70);

  @override
  State<StatefulWidget> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  late final backButtonVisibility = ValueNotifier<bool>(false);

  @override
  void initState() {
    widget.searchFocusNode?.addListener(onChangeFocus);
    super.initState();
  }

  void onChangeFocus() {
    backButtonVisibility.value = widget.searchFocusNode!.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: AppBar(
          elevation: 0,
          backgroundColor: BahagColor.nearlyWhite.withAlpha(200),
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          automaticallyImplyLeading: !widget.showProfileButton,
          title: Row(
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: backButtonVisibility,
                builder: (context, showBackButton, _) {
                  return Container(
                    padding: const EdgeInsets.only(right: 10),
                    height: 46,
                    width: 46,
                    child: widget.showBackButton || showBackButton
                        ? IconButton(
                            key: const Key('suggestionBackButton'),
                            onPressed: () {
                              widget.searchFocusNode?.unfocus();
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.go('/home');
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: BahagColor.nearlyBlack,
                            ),
                          )
                        : GestureDetector(
                            key: const Key('bauhausLogo'),
                            child: const Konglomerat(),
                            onTap: () {
                              context.go('/home');
                            },
                          ),
                  );
                },
              ),
              Expanded(
                flex: 1,
                child: SearchBar(
                  focusNode: widget.searchFocusNode,
                  height: widget.borderHeight,
                  autofocus: widget.autofocus,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: ProfileButton(
                  size: widget.borderHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.searchFocusNode?.removeListener(onChangeFocus);
    super.dispose();
  }
}

class ProfileButton extends StatelessWidget {
  final ImageProvider<Object>? profilePicture;
  final double size;

  const ProfileButton({
    super.key,
    this.profilePicture,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key ?? const Key('ProfileButton-Key'),
      onTap: () => GoRouter.of(context).push("/profile"),
      child: Center(
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: BahagColor.grey),
            borderRadius: BorderRadius.all(Radius.circular(size / 2)),
          ),
          child: profilePicture != null
              ? CircleAvatar(backgroundImage: profilePicture, radius: size / 2)
              : Icon(
                  Icons.person,
                  size: size / 2,
                  color: BahagColor.darkGrey,
                ),
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final FocusNode? focusNode;
  final double height;
  final bool autofocus;

  const SearchBar({
    super.key,
    this.focusNode,
    this.autofocus = false,
    this.height = 40,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final TextEditingController _controller;

  late final showClearButtonNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = "";
    widget.focusNode?.addListener(_handleFocusChange);
  }

  _handleFocusChange() {
    showClearButtonNotifier.value =
        (widget.focusNode!.hasFocus && _controller.text.isNotEmpty);
  }

  _textFieldUpdated(String updatedText) {
    if (updatedText.isNotEmpty) {
      showClearButtonNotifier.value = true;
    } else {
      showClearButtonNotifier.value = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.focusNode?.removeListener(_handleFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(widget.height / 2),
      ),
      borderSide: const BorderSide(
        width: 1,
        color: BahagColor.grey,
      ),
    );

    return TextField(
      key: const ValueKey('SearchBar'),
      focusNode: widget.focusNode,
      controller: _controller,
      autofocus: widget.autofocus,
      onEditingComplete: _navigateToProductList,
      onChanged: _textFieldUpdated,
      onTap: () {
        // final router = GoRouter.of(context);
        // if (router.location != "/suggestions") {
        //   router.push("/suggestions");
        // }
      },
      style: Theme.of(context)
          .textTheme
          .headline4
          ?.copyWith(fontWeight: FontWeight.normal),
      cursorColor: BahagColor.grey,
      decoration: InputDecoration(
        hintText: 'Wonach suchst du?',
        constraints: BoxConstraints(maxHeight: widget.height),
        contentPadding: const EdgeInsets.only(left: 17),
        suffixIconConstraints: BoxConstraints.expand(width: widget.height),
        isDense: true,
        suffixIcon: ValueListenableBuilder<bool>(
            valueListenable: showClearButtonNotifier,
            builder: (context, showClearButton, _) {
              return IconButton(
                onPressed: showClearButton
                    ? _clearSearchField
                    : _navigateToProductList,
                icon: Icon(
                  showClearButton ? Icons.close : Icons.search,
                  size: 20,
                  color: BahagColor.grey,
                ),
              );
            }),
        border: border,
        focusedBorder: border,
      ),
      textInputAction: TextInputAction.search,
      maxLines: 1,
    );
  }

  _clearSearchField() {
    _controller.clear();
    // due to this issue https://github.com/flutter/flutter/issues/83171
    // we still have to intimate the bloc manually instead of handling it
    // onChanged
    showClearButtonNotifier.value = false;
  }

  _navigateToProductList() {
    context.replace("/productList/${_controller.text}");
  }
}
