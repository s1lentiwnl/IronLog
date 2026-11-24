import 'package:flutter/material.dart';

import '../../model/support/Constants.dart';
import '../aspects/AppColors.dart';
import '../aspects/TextStyles.dart';

class PrGlanceCard extends StatelessWidget {
  final String exerciseName;
  final double weight;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const PrGlanceCard({
    super.key,
    required this.exerciseName,
    required this.weight,
    this.subtitle = Constants.labelBestLift,
    this.icon = Icons.fitness_center,
    this.onTap,
  });

  String _formatWeight(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor = isDark ? AppColors.surfaceDark : AppColors.cardWhite;
    final Color borderColor =
        isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight;
    final Color iconBgColor =
        isDark ? AppColors.iconBadgeDark : AppColors.iconBadgeLight;
    final Color iconColor =
        isDark ? AppColors.accentPill : AppColors.slateNavy;

    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor),
            boxShadow: isDark
                ? null
                : const [
                    BoxShadow(
                      color: AppColors.cardShadowLight,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: iconColor,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                exerciseName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: isDark ? TextStyles.bodyMediumDark : TextStyles.bodyMedium,
              ),
              const SizedBox(height: 6),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: _formatWeight(weight),
                      style: isDark
                          ? TextStyles.prWeightValueDark
                          : TextStyles.prWeightValue,
                    ),
                    TextSpan(
                      text: ' ${Constants.unitKg}',
                      style: isDark
                          ? TextStyles.prWeightUnitDark
                          : TextStyles.prWeightUnit,
                    ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: isDark ? TextStyles.captionDark : TextStyles.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
