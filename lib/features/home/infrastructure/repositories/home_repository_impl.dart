import 'package:nosrah/features/home/domain/entities/hadeeth.dart';
import 'package:nosrah/features/home/domain/entities/hashtag.dart';
import 'package:nosrah/features/home/domain/repo/home_repository.dart';
import 'package:nosrah/features/home/infrastructure/data_sources/home_remote_data_source.dart';
import 'package:nosrah/features/home/infrastructure/data_sources/home_remote_data_source_impl.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({HomeRemoteDataSource? homeRemoteDataSource})
      : homeRemoteDataSource =
            homeRemoteDataSource ?? HomeRemoteDataSourceImpl(),
        super();

  final HomeRemoteDataSource homeRemoteDataSource;

  @override
  Future<Hadeeth> getHadeeth() async => await homeRemoteDataSource.getHadeeth();

  @override
  Future<List<Hashtag>> getHashtags() async =>
      await homeRemoteDataSource.getHashtags();
}
