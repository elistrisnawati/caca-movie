part of 'movie_detail_watchlist_bloc.dart';

@immutable
abstract class MovieDetailWatchlistState extends Equatable {
  const MovieDetailWatchlistState();

  @override
  List<Object> get props => [];
}

class MovieDetailWatchlistEmpty extends MovieDetailWatchlistState {}

class MovieDetailWatchlistLoading extends MovieDetailWatchlistState {}

class MovieDetailWatchlistError extends MovieDetailWatchlistState {
  final String message;

  const MovieDetailWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailWatchlistHasData extends MovieDetailWatchlistState {
  bool isAddedToWatchlist = false;
  String watchlistMessage = "";

  MovieDetailWatchlistHasData(this.isAddedToWatchlist,
      {this.watchlistMessage = ""});

  @override
  List<Object> get props => [isAddedToWatchlist, watchlistMessage];
}
