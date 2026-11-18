import 'package:flutter/material.dart';

import '../../model/Model.dart';
import '../../model/support/Constants.dart';
import '../aspects/AppColors.dart';
import '../aspects/TextStyles.dart';

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

  @override
  Widget build(BuildContext context) {
    final model = Model.sharedInstance;
    final dayLabel =
        Constants.weekDayFullLabels[model.selectedDayOfWeek] ?? '';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              Constants.appName,
              style: TextStyles.headingLarge,
            ),
            const SizedBox(height: 4),
            Text(
              dayLabel,
              style: TextStyles.bodySecondary,
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.slateNavy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.plannedExercisesForSelectedDay.isEmpty
                        ? 'Enjoy your rest, you deserved it'
                        : model.plannedExercisesForSelectedDay.first.splitName,
                    style: TextStyles.heroTitle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${model.todayWorkoutCompletionPercentage.toStringAsFixed(0)}%',
                    style: TextStyles.heroSubtitle,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentPill,
                      foregroundColor: AppColors.textPrimary,
                    ),
                    onPressed: () {
                      model.setTabIndex(Constants.tabWorkout);
                    },
                    child: const Text(
                      Constants.labelNavWorkout,
                      style: TextStyles.pillLabel,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
