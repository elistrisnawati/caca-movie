part of 'tv_now_playing_bloc.dart';

@immutable
abstract class NowPlayingTvsEvent extends Equatable {
  const NowPlayingTvsEvent();

  @override
  List<Object> get props => [];
}

class OnRequested extends NowPlayingTvsEvent {
  final String query;

  const OnRequested(this.query);

  @override
  List<Object> get props => [query];
}
