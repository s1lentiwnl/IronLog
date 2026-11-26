import 'package:flutter/material.dart';

import '../../model/Model.dart';
import '../../model/support/Constants.dart';
import '../aspects/AppColors.dart';
import '../aspects/TextStyles.dart';
import '../widgets/PrGlanceCard.dart';
import '../widgets/WeekDaySelector.dart';
import '../widgets/buttons/CircularIconButton.dart';
import '../widgets/dialogs/AiAssistantDialog.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _onModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    Model.sharedInstance.addListener(_onModelChanged);
  }

  @override
  void dispose() {
    Model.sharedInstance.removeListener(_onModelChanged);
    super.dispose();
  }

  void _openAiAssistant() {
    AiAssistantDialog.show(context);
  }

  Widget _buildHeader(BuildContext context, Model model, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constants.appName,
          style: isDark ? TextStyles.brandLabelDark : TextStyles.brandLabel,
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Expanded(
              child: Text(
                Constants.labelToday,
                style: isDark
                    ? TextStyles.headingLargeDark
                    : TextStyles.headingLarge,
              ),
            ),
            Text(
              model.formattedTodayDate,
              style: isDark
                  ? TextStyles.bodySecondaryDark
                  : TextStyles.bodySecondary,
            ),
          ],
        ),
        const SizedBox(height: 16),
        WeekDaySelector(
          selectedDay: model.selectedDayOfWeek,
          onDaySelected: (int day) {
            model.selectDayOfWeek(day);
          },
        ),
      ],
    );
  }

  Widget _buildHeroCard(Model model) {
    final bool hasPlannedWorkout = model.plannedExercisesForSelectedDay.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.slateNavy,
        borderRadius: BorderRadius.circular(24),
      ),
      child: hasPlannedWorkout
          ? _buildPlannedWorkoutHeroContent(model)
          : _buildRestDayHeroContent(model),
    );
  }

  Widget _buildPlannedWorkoutHeroContent(Model model) {
    final double completionPercentage = model.todayWorkoutCompletionPercentage;
    final String previewExercises = model.selectedDayPreviewExercises;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                Constants.labelTodayWorkout,
                style: TextStyles.heroOverline,
              ),
              const SizedBox(height: 6),
              Text(
                model.selectedDaySplitName,
                style: TextStyles.heroSplitTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                '${Constants.labelStartsWith} $previewExercises',
                style: TextStyles.heroSubtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: () {
                  model.setTabIndex(Constants.tabWorkout);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentPill,
                  foregroundColor: AppColors.textPrimary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 11,
                  ),
                  shape: const StadiumBorder(),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        Constants.labelStartWorkout,
                        style: TextStyles.pillLabel,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 88,
          height: 88,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 88,
                height: 88,
                child: CircularProgressIndicator(
                  value: (completionPercentage / 100.0).clamp(0.0, 1.0),
                  strokeWidth: 7,
                  strokeCap: StrokeCap.round,
                  backgroundColor: AppColors.progressTrackOnDark,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.accentPill,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${completionPercentage.round()}%',
                    style: TextStyles.heroProgressValue,
                  ),
                  const Text(
                    Constants.labelCompleted,
                    style: TextStyles.heroProgressLabel,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRestDayHeroContent(Model model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.softSurfaceOnDark,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.self_improvement_rounded,
                size: 24,
                color: AppColors.accentPill,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              Constants.labelRestDayOverline,
              style: TextStyles.heroOverline,
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          Constants.labelRestDayMessage,
          style: TextStyles.heroTitle,
        ),
        const SizedBox(height: 18),
        ElevatedButton(
          onPressed: () {
            model.setTabIndex(Constants.tabPlanner);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentPill,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 11,
            ),
            shape: const StadiumBorder(),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Constants.labelPlanWorkout,
                style: TextStyles.pillLabel,
              ),
              SizedBox(width: 6),
              Icon(
                Icons.arrow_forward_rounded,
                size: 16,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrSection(Model model, bool isDark) {
    final List<MapEntry<String, double>> topPrs = model.topPersonalRecords;

    Widget buildSlot(int index) {
      if (index < topPrs.length) {
        final MapEntry<String, double> entry = topPrs[index];
        return PrGlanceCard(
          exerciseName: entry.key,
          weight: entry.value,
          subtitle: Constants.labelBestLift,
        );
      }
      return const PrGlanceCard(
        exerciseName: Constants.labelNoRecord,
        weight: 0,
        subtitle: Constants.labelNoRecordSubtitle,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constants.labelPrSectionTitle,
          style: isDark ? TextStyles.headingSmallDark : TextStyles.headingSmall,
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: buildSlot(0)),
            const SizedBox(width: 12),
            Expanded(child: buildSlot(1)),
          ],
        ),
      ],
    );
  }

  Widget _buildAiAssistantBar(bool isDark) {
    final Color borderColor =
        isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: borderColor),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Constants.labelAiBannerTitle,
                  style: isDark ? TextStyles.bodyLargeDark : TextStyles.bodyLarge,
                ),
                const SizedBox(height: 2),
                Text(
                  Constants.labelAiBannerSubtitle,
                  style: isDark ? TextStyles.captionDark : TextStyles.caption,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          CircularIconButton(
            icon: Icons.auto_awesome,
            tooltip: Constants.tooltipAiAssistant,
            onPressed: _openAiAssistant,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Model model = Model.sharedInstance;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, model, isDark),
                  const SizedBox(height: 20),
                  _buildHeroCard(model),
                  const SizedBox(height: 26),
                  _buildPrSection(model, isDark),
                ],
              ),
            ),
          ),
          _buildAiAssistantBar(isDark),
        ],
      ),
    );
  }
}
