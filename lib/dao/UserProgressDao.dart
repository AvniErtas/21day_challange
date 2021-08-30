import 'package:floor/floor.dart';
import 'package:flutter_app_21/entity/UserProgress.dart';

@dao
abstract class UserProgressDao {
  @Query('SELECT * FROM UserProgress')
  Future<List<UserProgress>> findAllUserProgress();

  @Query('SELECT * FROM UserProgress WHERE id = :id')
  Stream<UserProgress?> findUserProgressById(int id);

  @insert
  Future<void> insertUserProgress(UserProgress userProgress);

  @update
  Future<void> updateUserProgress(UserProgress userProgress);

  @Query('DELETE FROM UserProgress WHERE id = :id')
  Future<void> delete(int id);
}