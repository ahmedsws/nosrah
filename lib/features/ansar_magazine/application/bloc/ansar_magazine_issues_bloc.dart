import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nosrah/features/ansar_magazine/domain/entities/ansar_magazine_issue.dart';
import 'package:nosrah/features/ansar_magazine/domain/repo/ansar_magazine_repo.dart';
import 'package:nosrah/features/ansar_magazine/infrastructure/repositories/ansar_magazine_repo_impl.dart';

part 'ansar_magazine_issues_event.dart';
part 'ansar_magazine_issues_state.dart';

class AnsarMagazineIssuesBloc
    extends Bloc<AnsarMagazineIssuesEvent, AnsarMagazineIssuesState> {
  final AnsarMagazineRepository ansarMagazineRepository;
  AnsarMagazineIssuesBloc({AnsarMagazineRepository? ansarMagazineRepository})
      : ansarMagazineRepository =
            ansarMagazineRepository ?? AnsarMagazineRepositoryImpl(),
        super(AnsarMagazineIssuesLoading()) {
    on<AnsarMagazineIssuesEvent>((event, emit) async {
      if (event is GetAnsarMagazineIssues) {
        final ansarMagazineIssues =
            await this.ansarMagazineRepository.getMagazineIssues();

        return emit(AnsarMagazineIssuesLoaded(
            ansarMagazineIssues: ansarMagazineIssues));
      }
    });
  }
}
