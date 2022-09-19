import 'package:nosrah/features/home/domain/entities/hadeeth.dart';
import 'package:nosrah/features/home/infrastructure/models/hashtag_model.dart';

abstract class HomeRemoteDataSource {
  Future<Hadeeth> getHadeeth();

  Future<List<HashtagModel>> getHashtags();
}
