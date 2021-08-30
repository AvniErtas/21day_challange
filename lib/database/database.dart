import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_app_21/dao/UserProgressDao.dart';
import 'package:flutter_app_21/entity/UserProgress.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [UserProgress])
abstract class AppDatabase extends FloorDatabase {
  UserProgressDao get userProgressDao;
}