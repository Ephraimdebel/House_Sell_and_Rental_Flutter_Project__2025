// test/widget/favourite_page_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:house_rental_flutter/src/features/favourite/presentation/pages/favourite_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('Favourite Page loads with title', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: FavouritePage(),
        ),
      ),
    );

    expect(find.text('Favourites'), findsOneWidget);
  });
}
