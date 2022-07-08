part of 'movie_watchlist_bloc.dart';

@immutable
abstract class WatchlistMoviesEvent extends Equatable {
  const WatchlistMoviesEvent();

  @override
  List<Object> get props => [];
}

class OnRequested extends WatchlistMoviesEvent {

  const OnRequested();

  @override
  List<Object> get props => [];
}
