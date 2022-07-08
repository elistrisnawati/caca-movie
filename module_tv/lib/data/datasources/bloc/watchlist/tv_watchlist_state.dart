part of 'tv_watchlist_bloc.dart';

@immutable
abstract class WatchlistTvsState extends Equatable {
  const WatchlistTvsState();

  @override
  List<Object> get props => [];
}

class WatchlistTvsEmpty extends WatchlistTvsState {}

class WatchlistTvsLoading extends WatchlistTvsState {}

class WatchlistTvsError extends WatchlistTvsState {
  final String message;

  const WatchlistTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvsHasData extends WatchlistTvsState {
  final List<Tv> result;

  const WatchlistTvsHasData(this.result);

  @override
  List<Object> get props => [result];
}
