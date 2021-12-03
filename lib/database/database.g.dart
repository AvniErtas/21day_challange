// GENERATED CODE - DO NOT MODIFY BY HAND

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

  UserProgressDao? _userProgressDaoInstance;

  ChallangeNoteDao? _challangeNoteDaoInstance;

  OwnTaskDao? _ownTaskDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `UserProgress` (`id` INTEGER NOT NULL, `lastDay` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ChallangeNote` (`id` INTEGER NOT NULL, `dayId` INTEGER NOT NULL, `note` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OwnTask` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `baslik` TEXT NOT NULL, `aciklama` TEXT NOT NULL, `gunler` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserProgressDao get userProgressDao {
    return _userProgressDaoInstance ??=
        _$UserProgressDao(database, changeListener);
  }

  @override
  ChallangeNoteDao get challangeNoteDao {
    return _challangeNoteDaoInstance ??=
        _$ChallangeNoteDao(database, changeListener);
  }

  @override
  OwnTaskDao get ownTaskDao {
    return _ownTaskDaoInstance ??= _$OwnTaskDao(database, changeListener);
  }
}

class _$UserProgressDao extends UserProgressDao {
  _$UserProgressDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _userProgressInsertionAdapter = InsertionAdapter(
            database,
            'UserProgress',
            (UserProgress item) =>
                <String, Object?>{'id': item.id, 'lastDay': item.lastDay},
            changeListener),
        _userProgressUpdateAdapter = UpdateAdapter(
            database,
            'UserProgress',
            ['id'],
            (UserProgress item) =>
                <String, Object?>{'id': item.id, 'lastDay': item.lastDay},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserProgress> _userProgressInsertionAdapter;

  final UpdateAdapter<UserProgress> _userProgressUpdateAdapter;

  @override
  Future<List<UserProgress>> findAllUserProgress() async {
    return _queryAdapter.queryList('SELECT * FROM UserProgress',
        mapper: (Map<String, Object?> row) =>
            UserProgress(row['id'] as int, row['lastDay'] as int));
  }

  @override
  Stream<UserProgress?> findUserProgressById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM UserProgress WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            UserProgress(row['id'] as int, row['lastDay'] as int),
        arguments: [id],
        queryableName: 'UserProgress',
        isView: false);
  }

  @override
  Future<void> delete(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM UserProgress WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertUserProgress(UserProgress userProgress) async {
    await _userProgressInsertionAdapter.insert(
        userProgress, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUserProgress(UserProgress userProgress) async {
    await _userProgressUpdateAdapter.update(
        userProgress, OnConflictStrategy.abort);
  }
}

class _$ChallangeNoteDao extends ChallangeNoteDao {
  _$ChallangeNoteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _challangeNoteInsertionAdapter = InsertionAdapter(
            database,
            'ChallangeNote',
            (ChallangeNote item) => <String, Object?>{
                  'id': item.id,
                  'dayId': item.dayId,
                  'note': item.note
                }),
        _challangeNoteUpdateAdapter = UpdateAdapter(
            database,
            'ChallangeNote',
            ['id'],
            (ChallangeNote item) => <String, Object?>{
                  'id': item.id,
                  'dayId': item.dayId,
                  'note': item.note
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ChallangeNote> _challangeNoteInsertionAdapter;

  final UpdateAdapter<ChallangeNote> _challangeNoteUpdateAdapter;

  @override
  Future<List<ChallangeNote>> findAllChallangeNote() async {
    return _queryAdapter.queryList('SELECT * FROM ChallangeNote',
        mapper: (Map<String, Object?> row) => ChallangeNote(
            row['id'] as int, row['dayId'] as int, row['note'] as String));
  }

  @override
  Future<ChallangeNote?> findChallangeNoteByIdAndDayId(
      int id, int dayId) async {
    return _queryAdapter.query(
        'SELECT * FROM ChallangeNote WHERE id = ?1 AND dayId = ?2',
        mapper: (Map<String, Object?> row) => ChallangeNote(
            row['id'] as int, row['dayId'] as int, row['note'] as String),
        arguments: [id, dayId]);
  }

  @override
  Future<void> delete(int dayId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM ChallangeNote WHERE dayId = ?1',
        arguments: [dayId]);
  }

  @override
  Future<void> insertChallangeNote(ChallangeNote challangeNote) async {
    await _challangeNoteInsertionAdapter.insert(
        challangeNote, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateChallangeNote(ChallangeNote challangeNote) async {
    await _challangeNoteUpdateAdapter.update(
        challangeNote, OnConflictStrategy.abort);
  }
}

class _$OwnTaskDao extends OwnTaskDao {
  _$OwnTaskDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _ownTaskInsertionAdapter = InsertionAdapter(
            database,
            'OwnTask',
            (OwnTask item) => <String, Object?>{
                  'id': item.id,
                  'baslik': item.baslik,
                  'aciklama': item.aciklama,
                  'gunler': item.gunler
                }),
        _ownTaskUpdateAdapter = UpdateAdapter(
            database,
            'OwnTask',
            ['id'],
            (OwnTask item) => <String, Object?>{
                  'id': item.id,
                  'baslik': item.baslik,
                  'aciklama': item.aciklama,
                  'gunler': item.gunler
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OwnTask> _ownTaskInsertionAdapter;

  final UpdateAdapter<OwnTask> _ownTaskUpdateAdapter;

  @override
  Future<List<OwnTask>> findAllOwnTask() async {
    return _queryAdapter.queryList('SELECT * FROM OwnTask',
        mapper: (Map<String, Object?> row) => OwnTask(
            row['id'] as int?,
            row['baslik'] as String,
            row['aciklama'] as String,
            row['gunler'] as String));
  }

  @override
  Future<void> delete(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM OwnTask WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertOwnTask(OwnTask ownTask) async {
    await _ownTaskInsertionAdapter.insert(ownTask, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateOwnTask(OwnTask ownTask) async {
    await _ownTaskUpdateAdapter.update(ownTask, OnConflictStrategy.abort);
  }
}
