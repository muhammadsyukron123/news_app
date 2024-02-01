import 'package:hive/hive.dart';
part 'news_hive_model.g.dart';

@HiveType(typeId: 0)
class News extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String imgurl;

  @HiveField(3)
  late String url;


}