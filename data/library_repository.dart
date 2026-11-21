import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../models/library_item.dart';
import 'app_database.dart';

@lazySingleton
class LibraryRepository {
  final AppDatabase _database;

  LibraryRepository(this._database);

  Future<List<LibraryItem>> getAll() async {
    final rows = await _database.select(_database.libraryItems).get();

    return rows
        .map(
          (row) => LibraryItem(
        id: row.id,
        name: row.name,
        description: row.description,
        details: row.details,
        image: row.image,
      ),
    )
        .toList();
  }

  Future<int> add(LibraryItem item) {
    return _database.into(_database.libraryItems).insert(
      LibraryItemsCompanion.insert(
        name: item.name,
        description: item.description,
        details: item.details,
        image: item.image,
      ),
    );
  }

  Future<int> update(int id, LibraryItem item) {
    return (_database.update(_database.libraryItems)
      ..where((table) => table.id.equals(id)))
        .write(
      LibraryItemsCompanion(
        name: Value(item.name),
        description: Value(item.description),
        details: Value(item.details),
        image: Value(item.image),
      ),
    );
  }

  Future<int> delete(int id) {
    return (_database.delete(_database.libraryItems)
      ..where((table) => table.id.equals(id)))
        .go();
  }
}