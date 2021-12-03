import 'package:floor/floor.dart';

@entity
class OwnTask {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String baslik;
  final String aciklama;
  final String gunler;

  OwnTask(this.id,this.baslik, this.aciklama, this.gunler);
}