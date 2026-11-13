import 'package:flutter/material.dart';

import 'App.dart';
import 'model/Model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Model().initModel();
  } catch (e, stackTrace) {
    debugPrint('Errore durante initModel(): $e\n$stackTrace');
  }
  runApp(const App());
}
