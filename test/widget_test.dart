import 'package:flutter_test/flutter_test.dart';
import 'package:alyounes_app/main.dart';

void main() {
  testWidgets('App starts', (WidgetTester tester) async {
    await tester.pumpWidget(const AlYounesApp());
    expect(find.text('اليونسيون'), findsOneWidget);
  });
}
