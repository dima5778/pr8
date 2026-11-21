import 'package:drift/drift.dart';

@DataClassName('LibraryItemRow')
class LibraryItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get description => text()();

  TextColumn get details => text()();

  TextColumn get image => text()();
}
