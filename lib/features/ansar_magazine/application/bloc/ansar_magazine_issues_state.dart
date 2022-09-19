part of 'ansar_magazine_issues_bloc.dart';

@immutable
abstract class AnsarMagazineIssuesState {
  const AnsarMagazineIssuesState({
    this.ansarMagazineIssues,
  });

  final List<AnsarMagazineIssue>? ansarMagazineIssues;
}

class AnsarMagazineIssuesLoading extends AnsarMagazineIssuesState {}

class AnsarMagazineIssuesLoaded extends AnsarMagazineIssuesState {
  const AnsarMagazineIssuesLoaded({
    required List<AnsarMagazineIssue> ansarMagazineIssues,
  }) : super(
          ansarMagazineIssues: ansarMagazineIssues,
        );
}
