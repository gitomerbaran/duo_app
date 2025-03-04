import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/constants/app/app_constants.dart';
import '../../core/constants/navigate/navigate_constants.dart';
import '../../core/controllers/notifiers/onboard_controller.dart';
import '../../core/localization/app_strings.dart';
import '../../core/navigate/navigate_services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/icon_manager.dart';
import '../widgets/animation_onboard.dart';
import '../widgets/button.dart';
import '../widgets/onboard_title_row.dart';
import '../../core/extensions/context_extension.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final PageController _pageController = PageController();
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  final ValueNotifier<bool> buttonAnimation = ValueNotifier<bool>(false);
  Timer? _timer;
  final List<Map<String, String>> _games = [
    {"name": "League of Legends", "icon": "lol_icon.webp"},
    {"name": "Valorant", "icon": "valorant_icon.png"},
    {"name": "CS2", "icon": "cs2_icon.png"},
  ];
  final List<Map<String, String>> _ranks = [
    {"name": AppStrings.of().lolDiamondRank!, "icon": "lol_diamond.webp"},
    {"name": AppStrings.of().lolMasterRank!, "icon": "lol_master.webp"},
    {
      "name": AppStrings.of().lolGrandMasterRank!,
      "icon": "lol_grandmaster.webp"
    },
  ];
  final List<String> _lanes = [
    "lol_lane_bot.webp",
    "lol_lane_support.webp",
    "lol_lane_jungle.webp",
  ];
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _startLoop(); // All animations are managed here
  }

  void _startLoop() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      // changing game opt animate
      selectedIndex.value = (selectedIndex.value + 1) % _games.length;

      //Button animation trigger
      buttonAnimation.value = !buttonAnimation.value;

      // page rotation option
      if (timer.tick % 2 == 0) {
        // Change the page every 4 seconds
        int nextPage = (_pageController.page?.toInt() ?? 0) + 1;
        if (nextPage >= 2) nextPage = 0;

        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    _timer?.cancel(); // cancel the Timer so that it doesn't work unnecessarily.
    buttonAnimation.dispose();
    selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: context.height,
          width: context.width,
          decoration: BoxDecoration(gradient: AppTheme.getGradient(context)),
        ),
        SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: context.paddingNormalHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.mediumValue),
                  Text(AppStrings.of().onboardHeadLine!,
                      style: AppFonts(context).headlineMedium),
                  SizedBox(height: context.mediumValueSecond),
                  SizedBox(
                    height: context.largeValue * 2.5,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        /// ONBOARD FIRST PAGE
                        OnboardFirstPage(
                            selectedIndex: selectedIndex, games: _games),

                        /// ONBOARD SECOND PAGE
                        OnboardSecondPage(
                            selectedIndex: selectedIndex,
                            ranks: _ranks,
                            lanes: _lanes,
                            buttonAnimation: buttonAnimation),
                      ],
                    ),
                  ),
                  SizedBox(height: context.mediumValue),

                  /// SMOOTH PAGE COUNTER
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 2,
                      effect: WormEffect(),
                    ),
                  ),
                  SizedBox(height: context.mediumValueSecond),

                  /// SKIP ONBOARD BUTTON
                  Center(
                    child: CustomButton(
                      function: () async {
                        /// saving state to cache then onboard  screen not show again
                        onboardStateSave();
                        NavigationService.instance
                            .navigateToPage(path: NavigateConstants.LOGIN);
                      },
                      text: AppStrings.of().onboardSkipPageTitle!,
                      height: context.mediumValueSecond,
                      widht: context.mediumValueWidht,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class OnboardSecondPage extends StatelessWidget {
  const OnboardSecondPage({
    super.key,
    required this.selectedIndex,
    required List<Map<String, String>> ranks,
    required List<String> lanes,
    required this.buttonAnimation,
  })  : _ranks = ranks,
        _lanes = lanes;

  final ValueNotifier<int> selectedIndex;
  final List<Map<String, String>> _ranks;
  final List<String> _lanes;
  final ValueNotifier<bool> buttonAnimation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnboardTitleRow(
          number: "3",
          title: AppStrings.of().onboardThirdTitle!,
        ),
        SizedBox(height: context.normalValue),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: AnimationGameList(
                selectedIndex: selectedIndex,
                games: _ranks,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _lanes.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Image.asset(
                            IconManager.instance.toPng(_lanes[index]),
                            height: context.mediumValue,
                            width: context.mediumValue,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: context.mediumValueSecond),
        OnboardTitleRow(
            number: "4", title: AppStrings.of().onboardFourthTitle!),
        SizedBox(height: context.normalValue),
        ValueListenableBuilder<bool>(
          valueListenable: buttonAnimation,
          builder: (context, value, child) => value
              ? CircularProgressIndicator(
                  color: AppColors.secondary(context),
                )
              : CustomButton(
                  function: () {},
                  text: AppStrings.of().findTeam!,
                  height: context.mediumValue,
                  widht: context.mediumValueWidht),
        )
      ],
    );
  }
}

class OnboardFirstPage extends StatelessWidget {
  const OnboardFirstPage({
    super.key,
    required this.selectedIndex,
    required this.games,
  });

  final ValueNotifier<int> selectedIndex;
  final List<Map<String, String>> games;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Title
        OnboardTitleRow(
          number: "1",
          title: AppStrings.of().onboardFirstTitle!,
        ),
        SizedBox(height: context.normalValue),
        //With Animation game list
        AnimationGameList(selectedIndex: selectedIndex, games: games),

        SizedBox(height: context.mediumValueSecond),

        // Second Title
        OnboardTitleRow(
            number: "2", title: AppStrings.of().onboardSecondtTitle!),
        SizedBox(height: context.mediumValue),
        //With Animation nickname text
        Center(
          child: AnimatedText(),
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothIndicator(
      effect: WormEffect(),
      offset: 3,
      count: 2,
      size: Size(context.lowValueWidht, context.lowValue),
    );
  }
}

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.largeValue,
      height: context.highValue / 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.onBoardNickName(context),
          borderRadius: BorderRadius.circular(20)),
      child: AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(AppConstants.ONBOARD_NAME_TEXT,
              textStyle: AppFonts(context).bodyNormalText,
              speed: Duration(milliseconds: 150)),
        ],
        repeatForever: true,
      ),
    );
  }
}
