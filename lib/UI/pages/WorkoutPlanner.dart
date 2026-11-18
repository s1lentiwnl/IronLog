import 'package:flutter/material.dart';

import '../../model/Model.dart';
import '../../model/support/Constants.dart';
import '../aspects/TextStyles.dart';

class WorkoutPlanner extends StatefulWidget {
  const WorkoutPlanner({super.key});

  @override
  State<WorkoutPlanner> createState() => _WorkoutPlannerState();
}

class _WorkoutPlannerState extends State<WorkoutPlanner> {
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
              Constants.labelNavPlanner,
              style: TextStyles.headingLarge,
            ),
            const SizedBox(height: 4),
            Text(
              dayLabel,
              style: TextStyles.bodySecondary,
            ),
          ],
        ),
      ),
    );
  }
}
