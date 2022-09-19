import 'package:nosrah/features/ansar_magazine/domain/entities/ansar_magazine_issue.dart';

abstract class AnsarMagazineRepository {
  Future<List<AnsarMagazineIssue>> getMagazineIssues();
}
