import 'package:flutter_test/flutter_test.dart';
import 'package:navigation_practice/main.dart';

void main() {
  testWidgets('opens a product and returns to the list', (tester) async {
    await tester.pumpWidget(const ProductNavigationApp());

    expect(find.text('Product Navigation'), findsOneWidget);
    expect(find.text('Pixel'), findsOneWidget);

    await tester.tap(find.text('Pixel'));
    await tester.pumpAndSettle();

    expect(find.text('Price: 800'), findsOneWidget);
    expect(find.text('Pixel'), findsNWidgets(2));

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Product Navigation'), findsOneWidget);
    expect(find.text('Pixel'), findsOneWidget);
  });
}
