import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_movie/domain/entities/movie/movie_detail.dart';
import 'package:module_movie/domain/usecases/movie/get_watchlist_status_movie.dart';
import 'package:module_movie/domain/usecases/movie/remove_movie_watchlist.dart';
import 'package:module_movie/domain/usecases/movie/save_movie_watchlist.dart';

part 'movie_detail_watchlist_event.dart';
part 'movie_detail_watchlist_state.dart';

class MovieDetailWatchlistBloc
    extends Bloc<MovieDetailWatchlistEvent, MovieDetailWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatusMovie _getWatchListStatus;
  final SaveWatchlistMovie _saveWatchlist;
  final RemoveWatchlistMovie _removeWatchlist;

  late String watchlistMessage = "";

  MovieDetailWatchlistBloc(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(MovieDetailWatchlistEmpty()) {
    on<OnRequestedWatchlistStatus>(
      (event, emit) async {
        print("OnRequestedWatchlistStatus");
        final movieDetailId = event.movieDetailId;

        emit(MovieDetailWatchlistLoading());
        final isAddedToWatchlist =
            await _getWatchListStatus.execute(movieDetailId);
        emit(MovieDetailWatchlistHasData(isAddedToWatchlist));
        print("OnRequestedWatchlistStatus DONE");
      },
    );

    on<OnRequestedSaveWatchlist>(
      (event, emit) async {
        print("OnRequestedSaveWatchlist");

        final movieDetail = event.movieDetail;

        emit(MovieDetailWatchlistLoading());

        final result = await _saveWatchlist.execute(movieDetail);
        await result.fold(
          (failure) async {
            watchlistMessage = failure.message;
          },
          (successMessage) async {
            watchlistMessage = successMessage;
          },
        );

        OnRequestedWatchlistStatus(movieDetail.id);

        print("OnRequestedSaveWatchlist DONE");
      },
    );

    on<OnRequestedRemoveWatchlist>(
      (event, emit) async {
        print("OnRequestedRemoveWatchlist");

        final movieDetail = event.movieDetail;

        emit(MovieDetailWatchlistLoading());
        final result = await _removeWatchlist.execute(movieDetail);
        await result.fold(
          (failure) async {
            watchlistMessage = failure.message;
          },
          (successMessage) async {
            watchlistMessage = successMessage;
          },
        );

        OnRequestedWatchlistStatus(movieDetail.id);

        print("OnRequestedRemoveWatchlist DONE");
      },
    );
  }
}
