// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: library_private_types_in_public_api

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

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

  SelicForecastDao? _selicForecastDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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
            'CREATE TABLE IF NOT EXISTS `Investment` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `investedAmount` REAL NOT NULL, `interestRate` REAL NOT NULL, `date` INTEGER NOT NULL, `incomeType` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Selic` (`date` INTEGER NOT NULL, `value` REAL NOT NULL, PRIMARY KEY (`date`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SelicForecast` (`id` INTEGER, `meeting` TEXT NOT NULL, `date` INTEGER NOT NULL, `median` REAL NOT NULL, `baseCalculo` INTEGER NOT NULL, PRIMARY KEY (`id`))');

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

  @override
  SelicForecastDao get selicForecastDao {
    return _selicForecastDaoInstance ??=
        _$SelicForecastDao(database, changeListener);
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
                  'date': _dateTimeConverter.encode(item.date),
                  'incomeType':
                      _investmentIncomeTypeConverter.encode(item.incomeType)
                },
            changeListener),
        _investmentUpdateAdapter = UpdateAdapter(
            database,
            'Investment',
            ['id'],
            (Investment item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'investedAmount': item.investedAmount,
                  'interestRate': item.interestRate,
                  'date': _dateTimeConverter.encode(item.date),
                  'incomeType':
                      _investmentIncomeTypeConverter.encode(item.incomeType)
                },
            changeListener),
        _investmentDeletionAdapter = DeletionAdapter(
            database,
            'Investment',
            ['id'],
            (Investment item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'investedAmount': item.investedAmount,
                  'interestRate': item.interestRate,
                  'date': _dateTimeConverter.encode(item.date),
                  'incomeType':
                      _investmentIncomeTypeConverter.encode(item.incomeType)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Investment> _investmentInsertionAdapter;

  final UpdateAdapter<Investment> _investmentUpdateAdapter;

  final DeletionAdapter<Investment> _investmentDeletionAdapter;

  @override
  Stream<List<Investment>> getInvestments() {
    return _queryAdapter.queryListStream('SELECT * FROM Investment',
        mapper: (Map<String, Object?> row) => Investment(
            id: row['id'] as int?,
            name: row['name'] as String,
            investedAmount: row['investedAmount'] as double,
            interestRate: row['interestRate'] as double,
            date: _dateTimeConverter.decode(row['date'] as int),
            incomeType: _investmentIncomeTypeConverter
                .decode(row['incomeType'] as int)),
        queryableName: 'Investment',
        isView: false);
  }

  @override
  Stream<Investment?> findInvestmentById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Investment WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Investment(
            id: row['id'] as int?,
            name: row['name'] as String,
            investedAmount: row['investedAmount'] as double,
            interestRate: row['interestRate'] as double,
            date: _dateTimeConverter.decode(row['date'] as int),
            incomeType: _investmentIncomeTypeConverter
                .decode(row['incomeType'] as int)),
        arguments: [id],
        queryableName: 'Investment',
        isView: false);
  }

  @override
  Future<void> insertInvestment(Investment investment) async {
    await _investmentInsertionAdapter.insert(
        investment, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateInvestment(Investment investment) async {
    await _investmentUpdateAdapter.update(investment, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteInvestment(Investment investment) async {
    await _investmentDeletionAdapter.delete(investment);
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

class _$SelicForecastDao extends SelicForecastDao {
  _$SelicForecastDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _selicForecastInsertionAdapter = InsertionAdapter(
            database,
            'SelicForecast',
            (SelicForecast item) => <String, Object?>{
                  'id': item.id,
                  'meeting': _meetingModelTypeConverter.encode(item.meeting),
                  'date': _dateTimeConverter.encode(item.date),
                  'median': item.median,
                  'baseCalculo': item.baseCalculo
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SelicForecast> _selicForecastInsertionAdapter;

  @override
  Future<double?> getSelicAverageBetweenMeetings(
    MeetingModel greaterMeeting,
    MeetingModel lessMeeting,
  ) async {
    return _queryAdapter.query(
        'SELECT AVG(sf.median) from SelicForecast sf where date = (SELECT max(date) as maxDate from  SelicForecast) and baseCalculo = 0 and meeting >= ?1 and meeting <= ?2',
        mapper: (Map<String, Object?> row) => row.values.first as double,
        arguments: [
          _meetingModelTypeConverter.encode(greaterMeeting),
          _meetingModelTypeConverter.encode(lessMeeting)
        ]);
  }

  @override
  Stream<List<SelicForecast>> getLastForecastByMeeting(MeetingModel meeting) {
    return _queryAdapter.queryListStream(
        'SELECT * from SelicForecast sf where date = (SELECT max(date) as maxDate from  SelicForecast) and baseCalculo = 0 and meeting >= ?1 group by meeting  order by  meeting asc limit 8',
        mapper: (Map<String, Object?> row) => SelicForecast(
            id: row['id'] as int?,
            meeting:
                _meetingModelTypeConverter.decode(row['meeting'] as String),
            date: _dateTimeConverter.decode(row['date'] as int),
            baseCalculo: row['baseCalculo'] as int,
            median: row['median'] as double),
        arguments: [_meetingModelTypeConverter.encode(meeting)],
        queryableName: 'SelicForecast',
        isView: false);
  }

  @override
  Future<int?> getLastDate() async {
    return _queryAdapter.query('SELECT max(date) from SelicForecast sf',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertSelic(List<SelicForecast> selics) async {
    await _selicForecastInsertionAdapter.insertList(
        selics, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _investmentIncomeTypeConverter = InvestmentIncomeTypeConverter();
final _meetingModelTypeConverter = MeetingModelTypeConverter();
