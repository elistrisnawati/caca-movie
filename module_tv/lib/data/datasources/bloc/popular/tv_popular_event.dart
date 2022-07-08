part of 'tv_popular_bloc.dart';

@immutable
abstract class PopularTvsEvent extends Equatable {
  const PopularTvsEvent();

  @override
  List<Object> get props => [];
}

class OnRequested extends PopularTvsEvent {
  const OnRequested();

  @override
  List<Object> get props => [];
}
