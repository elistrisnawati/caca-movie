part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnRequested extends MovieDetailEvent {
  final int query;

  const OnRequested(this.query);

  @override
  List<Object> get props => [query];
}

class OnRequestedMovieRecommendation extends MovieDetailEvent {
  final int query;

  const OnRequestedMovieRecommendation(this.query);

  @override
  List<Object> get props => [query];
}

class OnRequestedWatchlistStatus extends MovieDetailEvent {
  final int movieDetailId;

  const OnRequestedWatchlistStatus(this.movieDetailId);

  @override
  List<Object> get props => [movieDetailId];
}

class OnRequestedSaveWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const OnRequestedSaveWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRequestedRemoveWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const OnRequestedRemoveWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
