import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/themes/pallette.dart';
import 'package:routemaster/routemaster.dart';

class AddPosts extends ConsumerStatefulWidget {
  const AddPosts({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPostsState();
}

class _AddPostsState extends ConsumerState<AddPosts> {
  void navigateToType(BuildContext context, String type) {
    Routemaster.of(context).push('/add-post/$type');
  }
  @override
  Widget build(BuildContext context) {
    double cardHeightWidth = kIsWeb ? 360 : 120;
    double iconSize = kIsWeb ? 120 : 60;
    final currentTheme = ref.watch(themeNotifierProvider);

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => navigateToType(context, 'image'),
            child: SizedBox(
              height: cardHeightWidth,
              width: cardHeightWidth,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: currentTheme.colorScheme.background,
                elevation: 16,
                child: Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: iconSize,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateToType(context, 'text'),
            child: SizedBox(
              height: cardHeightWidth,
              width: cardHeightWidth,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: currentTheme.backgroundColor,
                elevation: 16,
                child: Center(
                  child: Icon(
                    Icons.font_download_outlined,
                    size: iconSize,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => navigateToType(context, 'link'),
            child: SizedBox(
              height: cardHeightWidth,
              width: cardHeightWidth,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: currentTheme.backgroundColor,
                elevation: 16,
                child: Center(
                  child: Icon(
                    Icons.link_outlined,
                    size: iconSize,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
  }
}