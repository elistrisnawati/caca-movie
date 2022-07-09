part of 'tv_detail_watchlist_cubit.dart';

@immutable
abstract class TvDetailWatchlistEvent extends Equatable {
  const TvDetailWatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnRequestedWatchlistStatus extends TvDetailWatchlistEvent {
  final int tvDetailId;

  const OnRequestedWatchlistStatus(this.tvDetailId);

  @override
  List<Object> get props => [tvDetailId];
}

class OnRequestedSaveWatchlist extends TvDetailWatchlistEvent {
  final TvDetail tvDetail;

  const OnRequestedSaveWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class OnRequestedRemoveWatchlist extends TvDetailWatchlistEvent {
  final TvDetail tvDetail;

  const OnRequestedRemoveWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}
