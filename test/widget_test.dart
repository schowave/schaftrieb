import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:schaftrieb/app.dart';
import 'package:schaftrieb/widgets/property_map.dart';

void main() {
  testWidgets('app starts with no property selected',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Property Name App'), findsOneWidget);
    expect(find.text('Selected Property: None'), findsOneWidget);
    expect(find.byType(PropertyMap), findsOneWidget);
  });

  testWidgets('saves the entered name as owner of the selected property',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Selecting a region on the map calls this callback.
    tester
        .widget<PropertyMap>(find.byType(PropertyMap))
        .onSelectProperty('11522');
    await tester.pump();
    expect(find.text('Selected Property: 11522'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Erika Mustermann');
    await tester.ensureVisible(find.text('Save Property Owner'));
    await tester.tap(find.text('Save Property Owner'));
    await tester.pump();

    expect(find.text('11522: Erika Mustermann'), findsOneWidget);
    expect(find.text('Property owner saved: Erika Mustermann for 11522'),
        findsOneWidget);
  });

  testWidgets('does not save without a selected property',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField), 'Erika Mustermann');
    await tester.ensureVisible(find.text('Save Property Owner'));
    await tester.tap(find.text('Save Property Owner'));
    await tester.pump();

    expect(find.textContaining(': Erika Mustermann'), findsNothing);
    expect(find.byType(SnackBar), findsNothing);
  });
}
