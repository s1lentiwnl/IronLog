import 'package:flutter/material.dart';

import '../../model/Model.dart';
import '../../model/support/Constants.dart';
import 'Home.dart';
import 'Settings.dart';
import 'WorkoutPlanner.dart';
import 'WorkoutViewer.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  static const List<Widget> _pages = [
    Home(),
    WorkoutPlanner(),
    WorkoutViewer(),
    Settings(),
  ];

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
    final currentIndex =
        model.currentTabIndex.clamp(0, _pages.length - 1);

    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          model.setTabIndex(index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: Constants.labelNavHome,
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: Constants.labelNavPlanner,
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: Constants.labelNavWorkout,
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: Constants.labelNavSettings,
          ),
        ],
      ),
    );
  }
}
