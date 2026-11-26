import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portofolio/main.dart';

void main() {
  testWidgets('PortfolioApp renders editorial sections without errors', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: PortfolioApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Wahyu Ajitomo'), findsWidgets);
    expect(find.text('Tentang'), findsWidgets);
    expect(find.text('Proyek Pilihan'), findsOneWidget);
    expect(find.text('Kontak'), findsWidgets);
  });
}
