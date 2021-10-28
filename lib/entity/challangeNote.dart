import 'package:floor/floor.dart';

@entity
class ChallangeNote {
  @primaryKey
  final int id;
  final int dayId;
  String note;

  ChallangeNote(this.id, this.dayId, this.note);
}