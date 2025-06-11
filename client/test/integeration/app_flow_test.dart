import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:house_rental_flutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login to Home flow', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Find and enter email/password (adjust widget keys as needed)
    await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
    await tester.enterText(find.byKey(Key('passwordField')), 'password123');

    // Tap login
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pumpAndSettle();

    // Check Home Screen appears
    expect(find.text('Welcome'), findsOneWidget);
  });
}
