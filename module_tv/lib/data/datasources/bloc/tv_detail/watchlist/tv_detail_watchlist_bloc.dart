import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_tv/domain/entities/tv/tv_detail.dart';
import 'package:module_tv/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:module_tv/domain/usecases/tv/remove_tv_watchlist.dart';
import 'package:module_tv/domain/usecases/tv/save_tv_watchlist.dart';

part 'tv_detail_watchlist_event.dart';
part 'tv_detail_watchlist_state.dart';

class TvDetailWatchlistBloc
    extends Bloc<TvDetailWatchlistEvent, TvDetailWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatusTv _getWatchListStatus;
  final SaveWatchlistTv _saveWatchlist;
  final RemoveWatchlistTv _removeWatchlist;

  late String watchlistMessage = "";

  TvDetailWatchlistBloc(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(TvDetailWatchlistEmpty()) {
    on<OnRequestedWatchlistStatus>(
      (event, emit) async {
        print("OnRequestedWatchlistStatus");
        final tvDetailId = event.tvDetailId;

        emit(TvDetailWatchlistLoading());

        final isAddedToWatchlist =
            await _getWatchListStatus.execute(tvDetailId);
        print("OnRequestedWatchlistStatus LOAD: " +
            isAddedToWatchlist.toString());

        emit(TvDetailWatchlistHasData(isAddedToWatchlist));
        print("OnRequestedWatchlistStatus DONE");
      },
    );

    on<OnRequestedSaveWatchlist>(
      (event, emit) async {
        print("OnRequestedSaveWatchlist");

        final tvDetail = event.tvDetail;

        // emit(TvDetailWatchlistLoading());
        final result = await _saveWatchlist.execute(tvDetail);
        await result.fold(
          (failure) async {
            watchlistMessage = failure.message;
          },
          (successMessage) async {
            watchlistMessage = successMessage;
            emit(TvDetailWatchlistHasData(
              true,
              watchlistMessage: watchlistMessage,
            ));
          },
        );

        print("OnRequestedSaveWatchlist DONE");
      },
    );

    on<OnRequestedRemoveWatchlist>(
      (event, emit) async {
        print("OnRequestedRemoveWatchlist");

        final tvDetail = event.tvDetail;

        // emit(TvDetailWatchlistLoading());
        final result = await _removeWatchlist.execute(tvDetail);
        await result.fold(
          (failure) async {
            watchlistMessage = failure.message;
          },
          (successMessage) async {
            watchlistMessage = successMessage;
            emit(TvDetailWatchlistHasData(
              false,
              watchlistMessage: watchlistMessage,
            ));
          },
        );

        print("OnRequestedRemoveWatchlist DONE");
      },
    );
  }
}
