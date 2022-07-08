part of 'tv_top_rated_bloc.dart';

@immutable
abstract class TopRatedTvsEvent extends Equatable {
  const TopRatedTvsEvent();

  @override
  List<Object> get props => [];
}

class OnRequested extends TopRatedTvsEvent {
  const OnRequested();

  @override
  List<Object> get props => [];
}
