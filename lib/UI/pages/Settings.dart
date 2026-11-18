import 'package:flutter/material.dart';

import '../../model/Model.dart';
import '../../model/support/Constants.dart';
import '../aspects/TextStyles.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Constants.labelNavSettings,
              style: TextStyles.headingLarge,
            ),
          ],
        ),
      ),
    );
  }
}
