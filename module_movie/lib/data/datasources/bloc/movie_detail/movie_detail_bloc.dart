import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_movie/domain/entities/movie/movie_detail.dart';
import 'package:module_movie/domain/usecases/movie/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;

  late String watchlistMessage = "";

  final MovieDetailHasData movieDetailHasData = MovieDetailHasData();

  MovieDetailBloc(
    this._getMovieDetail,
  ) : super(MovieDetailEmpty()) {
    on<OnRequestedMovieDetail>(
      (event, emit) async {
        final query = event.query;

        emit(MovieDetailLoading());
        final result = await _getMovieDetail.execute(query);

        result.fold(
          (failure) {
            emit(MovieDetailError(failure.message));
          },
          (data) {
            movieDetailHasData.movie = data;
            emit(movieDetailHasData);
          },
        );
      },
    );
  }
}
