import 'package:nosrah/features/ansar_magazine/domain/entities/ansar_magazine_issue.dart';

class AnsarMagazineIssueModel extends AnsarMagazineIssue {
  const AnsarMagazineIssueModel({
    required String issueNumber,
    required String url,
  }) : super(
          issueNumber: issueNumber,
          url: url,
        );

  AnsarMagazineIssueModel.fromJson(Map<String, dynamic> json)
      : super(
          issueNumber: json['issue_number'],
          url: json['url'],
        );
}
