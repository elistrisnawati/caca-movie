part of 'movie_detail_watchlist_cubit.dart';

@immutable
abstract class MovieDetailWatchlistEvent extends Equatable {
  const MovieDetailWatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnRequestedWatchlistStatus extends MovieDetailWatchlistEvent {
  final int movieDetailId;

  const OnRequestedWatchlistStatus(this.movieDetailId);

  @override
  List<Object> get props => [movieDetailId];
}

class OnRequestedSaveWatchlist extends MovieDetailWatchlistEvent {
  final MovieDetail movieDetail;

  const OnRequestedSaveWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRequestedRemoveWatchlist extends MovieDetailWatchlistEvent {
  final MovieDetail movieDetail;

  const OnRequestedRemoveWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
