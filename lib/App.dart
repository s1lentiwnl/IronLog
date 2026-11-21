import 'package:flutter/material.dart';

import 'UI/aspects/AppColors.dart';
import 'UI/pages/Layout.dart';
import 'model/support/Constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppColors.lightTheme,
      darkTheme: AppColors.darkTheme,
      home: const Layout(),
    );
  }
}
