import 'package:flutter/material.dart';

import '../../../model/support/Constants.dart';
import '../../aspects/AppColors.dart';
import '../../aspects/TextStyles.dart';

class AiAssistantDialog extends StatefulWidget {
  final String Function(String query)? onRequestAlternative;

  const AiAssistantDialog({
    super.key,
    this.onRequestAlternative,
  });

  static Future<void> show(
    BuildContext context, {
    String Function(String query)? onRequestAlternative,
  }) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.cardWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (BuildContext sheetContext) {
        return AiAssistantDialog(
          onRequestAlternative: onRequestAlternative,
        );
      },
    );
  }

  @override
  State<AiAssistantDialog> createState() => _AiAssistantDialogState();
}

class _AiAssistantDialogState extends State<AiAssistantDialog> {
  late final TextEditingController _queryController;
  String? _errorMessage;
  String? _responseMessage;

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController();
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _handleAskAlternative() {
    final String query = _queryController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _errorMessage = Constants.labelAiEmptyInputError;
        _responseMessage = null;
      });
      return;
    }

    final String response = widget.onRequestAlternative != null
        ? widget.onRequestAlternative!(query)
        : 'Se "$query" è occupato, prova una variante equivalente con manubri o ai cavi mantenendo lo stesso schema di serie, ripetizioni e tempo di recupero.';

    setState(() {
      _errorMessage = null;
      _responseMessage = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final Color borderColor =
        isDark ? AppColors.cardBorderDark : AppColors.cardBorderLight;
    final Color inputFillColor =
        isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color responseBgColor =
        isDark ? AppColors.iconBadgeDark : AppColors.iconBadgeLight;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 12, 20, bottomInset + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.accentPill,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    size: 20,
                    color: AppColors.slateNavy,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    Constants.labelAiDialogTitle,
                    style: isDark
                        ? TextStyles.headingSmallDark
                        : TextStyles.headingSmall,
                  ),
                ),
                IconButton(
                  tooltip: Constants.labelClose,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close_rounded,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              Constants.labelAiDialogSubtitle,
              style: isDark
                  ? TextStyles.bodySecondaryDark
                  : TextStyles.bodySecondary,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _queryController,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _handleAskAlternative(),
              style: isDark ? TextStyles.bodyMediumDark : TextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: Constants.labelAiInputHint,
                hintStyle: isDark
                    ? TextStyles.bodySecondaryDark
                    : TextStyles.bodySecondary,
                errorText: _errorMessage,
                filled: true,
                fillColor: inputFillColor,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.slateNavy,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _handleAskAlternative,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.slateNavy,
                  foregroundColor: AppColors.textOnDark,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.auto_awesome, size: 18),
                label: const Text(
                  Constants.labelAiAskButton,
                  style: TextStyles.buttonLabelOnDark,
                ),
              ),
            ),
            if (_responseMessage != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: responseBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline_rounded,
                          size: 18,
                          color: isDark
                              ? AppColors.accentPill
                              : AppColors.slateNavy,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          Constants.labelAiResponseTitle,
                          style: isDark
                              ? TextStyles.bodyMediumDark
                              : TextStyles.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _responseMessage!,
                      style: isDark
                          ? TextStyles.bodyMediumDark
                          : TextStyles.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      Constants.labelAiResponseNotice,
                      style:
                          isDark ? TextStyles.captionDark : TextStyles.caption,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
