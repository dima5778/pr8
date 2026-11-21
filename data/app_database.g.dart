// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LibraryItemsTable extends LibraryItems
    with TableInfo<$LibraryItemsTable, LibraryItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LibraryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description, details, image];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'library_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<LibraryItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    } else if (isInserting) {
      context.missing(_detailsMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LibraryItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LibraryItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      )!,
    );
  }

  @override
  $LibraryItemsTable createAlias(String alias) {
    return $LibraryItemsTable(attachedDatabase, alias);
  }
}

class LibraryItemRow extends DataClass implements Insertable<LibraryItemRow> {
  final int id;
  final String name;
  final String description;
  final String details;
  final String image;
  const LibraryItemRow({
    required this.id,
    required this.name,
    required this.description,
    required this.details,
    required this.image,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['details'] = Variable<String>(details);
    map['image'] = Variable<String>(image);
    return map;
  }

  LibraryItemsCompanion toCompanion(bool nullToAbsent) {
    return LibraryItemsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      details: Value(details),
      image: Value(image),
    );
  }

  factory LibraryItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LibraryItemRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      details: serializer.fromJson<String>(json['details']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'details': serializer.toJson<String>(details),
      'image': serializer.toJson<String>(image),
    };
  }

  LibraryItemRow copyWith({
    int? id,
    String? name,
    String? description,
    String? details,
    String? image,
  }) => LibraryItemRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    details: details ?? this.details,
    image: image ?? this.image,
  );
  LibraryItemRow copyWithCompanion(LibraryItemsCompanion data) {
    return LibraryItemRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      details: data.details.present ? data.details.value : this.details,
      image: data.image.present ? data.image.value : this.image,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LibraryItemRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('details: $details, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, details, image);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LibraryItemRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.details == this.details &&
          other.image == this.image);
}

class LibraryItemsCompanion extends UpdateCompanion<LibraryItemRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> details;
  final Value<String> image;
  const LibraryItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.details = const Value.absent(),
    this.image = const Value.absent(),
  });
  LibraryItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    required String details,
    required String image,
  }) : name = Value(name),
       description = Value(description),
       details = Value(details),
       image = Value(image);
  static Insertable<LibraryItemRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? details,
    Expression<String>? image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (details != null) 'details': details,
      if (image != null) 'image': image,
    });
  }

  LibraryItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? details,
    Value<String>? image,
  }) {
    return LibraryItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      details: details ?? this.details,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LibraryItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('details: $details, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LibraryItemsTable libraryItems = $LibraryItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [libraryItems];
}

typedef $$LibraryItemsTableCreateCompanionBuilder =
    LibraryItemsCompanion Function({
      Value<int> id,
      required String name,
      required String description,
      required String details,
      required String image,
    });
typedef $$LibraryItemsTableUpdateCompanionBuilder =
    LibraryItemsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<String> details,
      Value<String> image,
    });

class $$LibraryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $LibraryItemsTable> {
  $$LibraryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LibraryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $LibraryItemsTable> {
  $$LibraryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LibraryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LibraryItemsTable> {
  $$LibraryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);
}

class $$LibraryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LibraryItemsTable,
          LibraryItemRow,
          $$LibraryItemsTableFilterComposer,
          $$LibraryItemsTableOrderingComposer,
          $$LibraryItemsTableAnnotationComposer,
          $$LibraryItemsTableCreateCompanionBuilder,
          $$LibraryItemsTableUpdateCompanionBuilder,
          (
            LibraryItemRow,
            BaseReferences<_$AppDatabase, $LibraryItemsTable, LibraryItemRow>,
          ),
          LibraryItemRow,
          PrefetchHooks Function()
        > {
  $$LibraryItemsTableTableManager(_$AppDatabase db, $LibraryItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LibraryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LibraryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LibraryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> details = const Value.absent(),
                Value<String> image = const Value.absent(),
              }) => LibraryItemsCompanion(
                id: id,
                name: name,
                description: description,
                details: details,
                image: image,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String description,
                required String details,
                required String image,
              }) => LibraryItemsCompanion.insert(
                id: id,
                name: name,
                description: description,
                details: details,
                image: image,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LibraryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LibraryItemsTable,
      LibraryItemRow,
      $$LibraryItemsTableFilterComposer,
      $$LibraryItemsTableOrderingComposer,
      $$LibraryItemsTableAnnotationComposer,
      $$LibraryItemsTableCreateCompanionBuilder,
      $$LibraryItemsTableUpdateCompanionBuilder,
      (
        LibraryItemRow,
        BaseReferences<_$AppDatabase, $LibraryItemsTable, LibraryItemRow>,
      ),
      LibraryItemRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LibraryItemsTableTableManager get libraryItems =>
      $$LibraryItemsTableTableManager(_db, _db.libraryItems);
}
