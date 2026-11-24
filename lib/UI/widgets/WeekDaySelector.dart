import 'package:flutter/material.dart';

import '../../model/support/Constants.dart';
import '../aspects/AppColors.dart';
import '../aspects/TextStyles.dart';

class WeekDaySelector extends StatelessWidget {
  final int selectedDay;
  final ValueChanged<int> onDaySelected;
  final DateTime? referenceDate;

  const WeekDaySelector({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
    this.referenceDate,
  });

  List<DateTime> _currentWeekDates() {
    final DateTime anchor = referenceDate ?? DateTime.now();
    final DateTime normalizedAnchor = DateTime(
      anchor.year,
      anchor.month,
      anchor.day,
    );
    final DateTime monday = normalizedAnchor.subtract(
      Duration(days: normalizedAnchor.weekday - DateTime.monday),
    );
    return List<DateTime>.generate(
      Constants.weekDays.length,
      (int index) => monday.add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final List<DateTime> weekDates = _currentWeekDates();

    return Row(
      children: List<Widget>.generate(Constants.weekDays.length, (int index) {
        final int dayOfWeek = Constants.weekDays[index];
        final bool isSelected = dayOfWeek == selectedDay;
        final String initial = Constants.weekDayInitials[index];
        final int dayNumber = weekDates[index].day;

        final TextStyle initialStyle = isSelected
            ? TextStyles.weekDayInitialSelected
            : (isDark
                ? TextStyles.weekDayInitialUnselectedDark
                : TextStyles.weekDayInitialUnselected);

        final TextStyle numberStyle = isSelected
            ? TextStyles.weekDayNumberSelected
            : (isDark
                ? TextStyles.weekDayNumberUnselectedDark
                : TextStyles.weekDayNumberUnselected);

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => onDaySelected(dayOfWeek),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.slateNavy
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                    border: isSelected && isDark
                        ? Border.all(color: AppColors.cardBorderDark)
                        : null,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(initial, style: initialStyle),
                      const SizedBox(height: 6),
                      Text('$dayNumber', style: numberStyle),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
