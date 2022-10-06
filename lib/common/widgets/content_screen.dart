import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({
    required this.storageKey,
    required this.storageBucket,
    super.key,
  });
  final PageStorageKey storageKey;
  final PageStorageBucket storageBucket;

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late final ScrollController _scrollController;

  @override
  initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        widget.storageBucket.writeState(
            context, _scrollController.position.pixels,
            identifier: ValueKey(widget.storageKey));
      });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _restoreScrollPosition();
    });
  }

  void _restoreScrollPosition() {
    final oldState = widget.storageBucket
        .readState(context, identifier: ValueKey(widget.storageKey));
    if (oldState != null && oldState is double) {
      final double position = oldState;
      _scrollController.jumpTo(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      key: widget.key,
      bucket: widget.storageBucket,
      child: Container(
        color: Colors.redAccent,
        child: ListView(
          controller: _scrollController,
          children: [
            const SizedBox(height: 40),
            const Text("This is a text"),
            TextButton(
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.blueGrey),
              ),
              onPressed: () {
                GoRouter.of(context).push("/about");
              },
              child: const Text("open about"),
            ),
            const Text("an image"),
            Image.network("https://media.bahag.cloud/m/331936/12.webp"),
            const Text("an image"),
            Image.network("https://media.bahag.cloud/m/438662/12.webp"),
            const Text("an image"),
            Image.network("https://media.bahag.cloud/m/667058/12.webp"),
          ],
        ),
      ),
    );
  }
}
