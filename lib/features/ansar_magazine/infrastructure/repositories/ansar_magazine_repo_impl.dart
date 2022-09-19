import 'package:nosrah/features/ansar_magazine/domain/entities/ansar_magazine_issue.dart';
import 'package:nosrah/features/ansar_magazine/infrastructure/data_source/ansar_magazine_remote_data_source_impl.dart';

import '../../domain/repo/ansar_magazine_repo.dart';
import '../data_source/ansar_magazine_remote_data_source.dart';

class AnsarMagazineRepositoryImpl implements AnsarMagazineRepository {
  AnsarMagazineRepositoryImpl({
    AnsarMagazineRemoteDataSource? ansarMagazineRemoteDataSource,
  })  : ansarMagazineRemoteDataSource = ansarMagazineRemoteDataSource ??
            AnsarMagazineRemoteDataSourceImpl(),
        super();

  final AnsarMagazineRemoteDataSource ansarMagazineRemoteDataSource;

  @override
  Future<List<AnsarMagazineIssue>> getMagazineIssues() async =>
      await ansarMagazineRemoteDataSource.getMagazineIssues();
}
