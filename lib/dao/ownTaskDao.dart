import 'package:floor/floor.dart';
import 'package:flutter_app_21/entity/ownTask.dart';

@dao
abstract class OwnTaskDao {
  @Query('SELECT * FROM OwnTask')
  Future<List<OwnTask>> findAllOwnTask();

  @insert
  Future<void> insertOwnTask(OwnTask ownTask);

  @update
  Future<void> updateOwnTask(OwnTask ownTask);

  @Query('DELETE FROM OwnTask WHERE id = :id')
  Future<void> delete(int id);
}