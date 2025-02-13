import 'package:duo_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_fonts.dart';
import '../../core/utils/icon_manager.dart';

class AnimationGameList extends StatelessWidget {
  const AnimationGameList({
    super.key,
    required this.selectedIndex,
    required this.games,
  });

  final ValueNotifier<int> selectedIndex;
  final List<Map<String, String>> games;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, index, child) {
        return Column(
          children: List.generate(games.length, (i) {
            return AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: i == index ? 1.0 : 0.3,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: i == index
                      ? Border.all(color: Colors.blue, width: 2)
                      : null,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Image.asset(IconManager.instance.toPng(games[i]["icon"]!),
                        height: context.mediumValue),
                    SizedBox(width: context.normalValue),
                    Text(games[i]["name"]!,
                        style: AppFonts(context).bodySmallText),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
