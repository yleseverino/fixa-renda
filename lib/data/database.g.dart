// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: library_private_types_in_public_api, override_on_non_overriding_member

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  InvestmentDao? _investmentDaoInstance;

  SelicDao? _selicDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Investment` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `investedAmount` REAL NOT NULL, `interestRate` REAL NOT NULL, `date` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Selic` (`date` INTEGER NOT NULL, `value` REAL NOT NULL, PRIMARY KEY (`date`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  InvestmentDao get investmentDao {
    return _investmentDaoInstance ??= _$InvestmentDao(database, changeListener);
  }

  @override
  SelicDao get selicDao {
    return _selicDaoInstance ??= _$SelicDao(database, changeListener);
  }
}

class _$InvestmentDao extends InvestmentDao {
  _$InvestmentDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _investmentInsertionAdapter = InsertionAdapter(
            database,
            'Investment',
            (Investment item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'investedAmount': item.investedAmount,
                  'interestRate': item.interestRate,
                  'date': _dateTimeConverter.encode(item.date)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Investment> _investmentInsertionAdapter;

  @override
  Stream<List<Investment>> getInvestments() {
    return _queryAdapter.queryListStream('SELECT * FROM Investment',
        mapper: (Map<String, Object?> row) => Investment(
            id: row['id'] as int?,
            name: row['name'] as String,
            investedAmount: row['investedAmount'] as double,
            interestRate: row['interestRate'] as double,
            date: _dateTimeConverter.decode(row['date'] as int)),
        queryableName: 'Investment',
        isView: false);
  }

  @override
  Stream<Investment?> findInvestmentById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Investment id = ?1',
        mapper: (Map<String, Object?> row) => Investment(
            id: row['id'] as int?,
            name: row['name'] as String,
            investedAmount: row['investedAmount'] as double,
            interestRate: row['interestRate'] as double,
            date: _dateTimeConverter.decode(row['date'] as int)),
        arguments: [id],
        queryableName: 'Investment',
        isView: false);
  }

  @override
  Future<void> insertInvestment(Investment investment) async {
    await _investmentInsertionAdapter.insert(
        investment, OnConflictStrategy.abort);
  }
}

class _$SelicDao extends SelicDao {
  _$SelicDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _selicInsertionAdapter = InsertionAdapter(
            database,
            'Selic',
            (Selic item) => <String, Object?>{
                  'date': _dateTimeConverter.encode(item.date),
                  'value': item.value
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Selic> _selicInsertionAdapter;

  @override
  Future<double?> getSelicAverage(DateTime date) async {
    return _queryAdapter.query('SELECT AVG(value) FROM Selic WHERE date >= ?1',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [_dateTimeConverter.encode(date)]);
  }

  @override
  Future<int?> getCountDays(DateTime date) async {
    return _queryAdapter.query('SELECT COUNT(date) FROM Selic WHERE date >= ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [_dateTimeConverter.encode(date)]);
  }

  @override
  Future<int?> getLastDate() async {
    return _queryAdapter.query('SELECT MAX(date) FROM Selic',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Stream<int?> getCountDaysStream(DateTime date) {
    return _queryAdapter.queryStream(
        'SELECT COUNT(date) FROM Selic WHERE date >= ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [_dateTimeConverter.encode(date)],
        queryableName: 'Selic',
        isView: false);
  }

  Stream<double?> getSelicAverageStream(DateTime date) {
    return _queryAdapter.queryStream(
        'SELECT AVG(value) FROM Selic WHERE date >= ?1',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [_dateTimeConverter.encode(date)],
        queryableName: 'Selic',
        isView: false);
  }

  @override
  Future<List<Selic>> getSelicList() async {
    return _queryAdapter.queryList('SELECT * FROM Selic',
        mapper: (Map<String, Object?> row) => Selic(
            date: _dateTimeConverter.decode(row['date'] as int),
            value: row['value'] as double));
  }

  @override
  Future<void> insertSelic(Selic selic) async {
    await _selicInsertionAdapter.insert(selic, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
