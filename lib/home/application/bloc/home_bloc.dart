import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nosrah/home/domain/entities/hadeeth.dart';
import 'package:nosrah/home/domain/entities/hashtag.dart';
import 'package:nosrah/home/domain/repo/home_repository.dart';
import 'package:nosrah/home/infrastructure/repositories/home_repository_impl.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc({HomeRepository? homeRepository})
      : homeRepository = homeRepository ?? HomeRepositoryImpl(),
        super(HomeLoading()) {
    on<GetHomeData>(
      (event, emit) async {
        try {
          final hadeeth = await this.homeRepository.getHadeeth();
          final hashtags = await this.homeRepository.getHashtags();

          return emit(
            HomeLoaded(
              hadeeth: hadeeth,
              hashtags: hashtags,
            ),
          );
        } catch (e) {
          return emit(HomeError());
        }
      },
    );
  }
}
