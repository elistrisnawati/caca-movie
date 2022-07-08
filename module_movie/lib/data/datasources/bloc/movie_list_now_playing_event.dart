part of 'movie_list_now_playing_bloc.dart';

@immutable
abstract class MovieListNowPlayingEvent extends Equatable {
  const MovieListNowPlayingEvent();

  @override
  List<Object> get props => [];
}

class OnRequestedNowPlayingMovies extends MovieListNowPlayingEvent {
  const OnRequestedNowPlayingMovies();

  @override
  List<Object> get props => [];
}
