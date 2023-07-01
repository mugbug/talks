import 'package:dependency_injection/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tabbar/tabbar.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(TabbarScreen), findsOneWidget);
    });
  });
}
