import 'package:easy_dep_injection/repositories/mock_user_repo.dart';
import 'package:easy_dep_injection/screens/search/search.dart';
import 'package:easy_dep_injection/screens/search/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:easy_dep_injection/app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('happy path tests', () {
    testWidgets('present search and search a user',
        (WidgetTester tester) async {
      final mockUserRepo = MockUserRepo();

      runApp(const App());
      await tester.pumpAndSettle();

      final nameToEnter = mockUserRepo.mockUsers.first;
      final nameField = find.byKey(const ValueKey(Search.nameFieldKey));

      await tester.enterText(nameField, nameToEnter);
      await tester.pumpAndSettle();

      final tiles = find.byType(Tile, skipOffstage: false);
      expect(tiles, findsOneWidget);
    });
  });
}
