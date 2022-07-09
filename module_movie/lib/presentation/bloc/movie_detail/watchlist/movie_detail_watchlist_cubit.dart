import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_movie/domain/entities/movie/movie_detail.dart';
import 'package:module_movie/domain/usecases/movie/get_watchlist_status_movie.dart';
import 'package:module_movie/domain/usecases/movie/remove_movie_watchlist.dart';
import 'package:module_movie/domain/usecases/movie/save_movie_watchlist.dart';

part 'movie_detail_watchlist_event.dart';
part 'movie_detail_watchlist_state.dart';

class MovieDetailWatchlistCubit extends Cubit<MovieDetailWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatusMovie _getWatchListStatus;
  final SaveWatchlistMovie _saveWatchlist;
  final RemoveWatchlistMovie _removeWatchlist;

  late String watchlistMessage = "";

  MovieDetailWatchlistCubit(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(MovieDetailWatchlistEmpty()) {}

  Future<void> watchlistStatus(int movieDetailId) async {
    emit(MovieDetailWatchlistLoading());

    final isAddedToWatchlist = await _getWatchListStatus.execute(movieDetailId);

    emit(MovieDetailWatchlistHasData(isAddedToWatchlist));
  }

  Future<void> saveWatchlist(MovieDetail movieDetail) async {
    final result = await _saveWatchlist.execute(movieDetail);
    await result.fold(
      (failure) async {
        watchlistMessage = failure.message;
      },
      (successMessage) async {
        watchlistMessage = successMessage;
        emit(MovieDetailWatchlistHasData(
          true,
          watchlistMessage: watchlistMessage,
        ));
      },
    );
  }

  Future<void> removeWatchlist(MovieDetail movieDetail) async {
    final result = await _removeWatchlist.execute(movieDetail);
    await result.fold(
      (failure) async {
        watchlistMessage = failure.message;
      },
      (successMessage) async {
        watchlistMessage = successMessage;
        emit(MovieDetailWatchlistHasData(
          false,
          watchlistMessage: watchlistMessage,
        ));
      },
    );
  }
}
