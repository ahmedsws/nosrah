import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nosrah/features/ansar_magazine/domain/entities/ansar_magazine_issue.dart';
import 'package:nosrah/features/ansar_magazine/infrastructure/models/ansar_magazine_issue_model.dart';

import 'ansar_magazine_remote_data_source.dart';

class AnsarMagazineRemoteDataSourceImpl
    implements AnsarMagazineRemoteDataSource {
  @override
  Future<List<AnsarMagazineIssue>> getMagazineIssues() async {
    final ansarMagazineIssuesCollection = await FirebaseFirestore.instance
        .collection('ansar_magazine_issues')
        .get();

    final ansarMagazineIssuesDocs = ansarMagazineIssuesCollection.docs;

    if (ansarMagazineIssuesDocs.isNotEmpty) {
      return ansarMagazineIssuesDocs
          .map((ansarMagazineIssuesDocSnapshot) =>
              AnsarMagazineIssueModel.fromJson(
                  ansarMagazineIssuesDocSnapshot.data()))
          .toList();
    } else {
      return [];
    }
  }
}
