part of 'movie_now_playing_bloc.dart';

@immutable
abstract class NowPlayingMoviesState extends MovieListState {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesEmpty extends NowPlayingMoviesState {}

class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;

  const NowPlayingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMoviesHasData extends NowPlayingMoviesState {
  final List<Movie> result;

  const NowPlayingMoviesHasData(this.result);

  @override
  List<Object> get props => [result];
}
