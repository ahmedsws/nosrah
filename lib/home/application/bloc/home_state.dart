part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  const HomeState({this.hadeeth, this.hashtags});

  final Hadeeth? hadeeth;
  final List<Hashtag>? hashtags;
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    required Hadeeth hadeeth,
    required List<Hashtag> hashtags,
  }) : super(
          hadeeth: hadeeth,
          hashtags: hashtags,
        );
}

class HomeError extends HomeState {}
