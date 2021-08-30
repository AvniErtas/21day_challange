import 'package:floor/floor.dart';

@entity
class UserProgress {
  @primaryKey
  final int id;
  int lastDay;
  UserProgress(this.id, this.lastDay);
}