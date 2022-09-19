import 'package:nosrah/features/home/domain/entities/hadeeth.dart';
import 'package:nosrah/features/home/domain/entities/hashtag.dart';

abstract class HomeRepository {
  Future<Hadeeth> getHadeeth();

  Future<List<Hashtag>> getHashtags();
}
