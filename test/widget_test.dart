import 'package:flutter_test/flutter_test.dart';
import 'package:iron_log/App.dart';
import 'package:iron_log/model/support/Constants.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text(Constants.appName), findsOneWidget);
  });
}
