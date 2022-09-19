import 'package:nosrah/features/ansar_magazine/domain/entities/ansar_magazine_issue.dart';

abstract class AnsarMagazineRemoteDataSource {
  Future<List<AnsarMagazineIssue>> getMagazineIssues();
}
