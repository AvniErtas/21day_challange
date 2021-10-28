import 'package:floor/floor.dart';
import 'package:flutter_app_21/entity/challangeNote.dart';

@dao
abstract class ChallangeNoteDao {
  @Query('SELECT * FROM ChallangeNote')
  Future<List<ChallangeNote>> findAllChallangeNote();

  @Query('SELECT * FROM ChallangeNote WHERE id = :id AND dayId = :dayId')
  Future<ChallangeNote?> findChallangeNoteByIdAndDayId(int id,int dayId);

  @insert
  Future<void> insertChallangeNote(ChallangeNote challangeNote);

  @update
  Future<void> updateChallangeNote(ChallangeNote challangeNote);

  @Query('DELETE FROM ChallangeNote WHERE dayId = :dayId')
  Future<void> delete(int dayId);
}