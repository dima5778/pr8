import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';

import '../mock/library_data.dart' as seed;
import 'library_table.dart';

part 'app_database.g.dart';

@lazySingleton
@DriftDatabase(tables: [LibraryItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'library_database'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
      await batch((batch) {
        batch.insertAll(
          libraryItems,
          seed.libraryItems
              .map(
                (item) => LibraryItemsCompanion.insert(
              name: item.name,
              description: item.description,
              details: item.details,
              image: item.image,
            ),
          )
              .toList(),
        );
      });
    },
  );
}