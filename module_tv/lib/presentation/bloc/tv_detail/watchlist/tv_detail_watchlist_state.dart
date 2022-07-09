part of 'tv_detail_watchlist_cubit.dart';

@immutable
abstract class TvDetailWatchlistState extends Equatable {
  const TvDetailWatchlistState();

  @override
  List<Object> get props => [];
}

class TvDetailWatchlistEmpty extends TvDetailWatchlistState {}

class TvDetailWatchlistLoading extends TvDetailWatchlistState {}

class TvDetailWatchlistError extends TvDetailWatchlistState {
  final String message;

  const TvDetailWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailWatchlistHasData extends TvDetailWatchlistState {
  bool isAddedToWatchlist = false;
  String watchlistMessage = "";

  TvDetailWatchlistHasData(this.isAddedToWatchlist,
      {this.watchlistMessage = ""});

  @override
  List<Object> get props => [isAddedToWatchlist, watchlistMessage];
}
