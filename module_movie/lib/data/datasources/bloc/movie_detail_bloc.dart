import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_movie/domain/entities/movie/movie.dart';
import 'package:module_movie/domain/entities/movie/movie_detail.dart';
import 'package:module_movie/domain/usecases/movie/get_movie_detail.dart';
import 'package:module_movie/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:module_movie/domain/usecases/movie/get_watchlist_status_movie.dart';
import 'package:module_movie/domain/usecases/movie/remove_movie_watchlist.dart';
import 'package:module_movie/domain/usecases/movie/save_movie_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetWatchListStatusMovie _getWatchListStatus;
  final SaveWatchlistMovie _saveWatchlist;
  final RemoveWatchlistMovie _removeWatchlist;

  late String watchlistMessage = "";

  final MovieDetailHasData movieDetailHasData = MovieDetailHasData();

  MovieDetailBloc(this._getMovieDetail, this._getMovieRecommendations,
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(MovieDetailEmpty()) {
    on<OnRequested>(
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

    on<OnRequestedMovieRecommendation>(
      (event, emit) async {
        final query = event.query;

        emit(MovieDetailLoading());
        final result = await _getMovieRecommendations.execute(query);

        result.fold(
          (failure) {
            watchlistMessage = failure.message;
          },
          (data) {
            movieDetailHasData.movieRecommendations = data;
            emit(movieDetailHasData);
          },
        );
      },
    );

    on<OnRequestedWatchlistStatus>(
      (event, emit) async {
        final movieDetailId = event.movieDetailId;

        emit(MovieDetailLoading());
        final isAddedToWatchlist =
            await _getWatchListStatus.execute(movieDetailId);
        movieDetailHasData.isAddedToWatchlist = isAddedToWatchlist;
        emit(movieDetailHasData);
      },
    );

    on<OnRequestedSaveWatchlist>(
      (event, emit) async {
        final movieDetail = event.movieDetail;

        emit(MovieDetailLoading());

        final result = await _saveWatchlist.execute(movieDetailHasData.movie);
        await result.fold(
          (failure) async {
            watchlistMessage = failure.message;
          },
          (successMessage) async {
            watchlistMessage = successMessage;
          },
        );

        OnRequestedWatchlistStatus(movieDetail.id);
      },
    );

    on<OnRequestedRemoveWatchlist>(
      (event, emit) async {
        final movieDetail = event.movieDetail;

        emit(MovieDetailLoading());
        final result = await _removeWatchlist.execute(movieDetailHasData.movie);
        await result.fold(
          (failure) async {
            watchlistMessage = failure.message;
          },
          (successMessage) async {
            watchlistMessage = successMessage;
          },
        );

        OnRequestedWatchlistStatus(movieDetail.id);
      },
    );
  }
}
