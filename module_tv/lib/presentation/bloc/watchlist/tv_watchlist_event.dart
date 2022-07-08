part of 'tv_watchlist_bloc.dart';

@immutable
abstract class WatchlistTvsEvent extends Equatable {
  const WatchlistTvsEvent();

  @override
  List<Object> get props => [];
}

class OnRequested extends WatchlistTvsEvent {
  const OnRequested();

  @override
  List<Object> get props => [];
}
