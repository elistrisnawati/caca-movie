part of 'movie_now_playing_bloc.dart';

@immutable
abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnRequested extends NowPlayingMoviesEvent {
  final String query;

  const OnRequested(this.query);

  @override
  List<Object> get props => [query];
}
