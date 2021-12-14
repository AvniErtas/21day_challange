import 'package:floor/floor.dart';

@entity
class UserProgress {
  @primaryKey
  final int id;
  int lastDay;
  String dateTime;
  UserProgress(this.id, this.lastDay,this.dateTime);
}