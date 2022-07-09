import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_tv/domain/entities/tv/tv_detail.dart';
import 'package:module_tv/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:module_tv/domain/usecases/tv/remove_tv_watchlist.dart';
import 'package:module_tv/domain/usecases/tv/save_tv_watchlist.dart';

part 'tv_detail_watchlist_event.dart';
part 'tv_detail_watchlist_state.dart';

class TvDetailWatchlistCubit extends Cubit<TvDetailWatchlistState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatusTv _getWatchListStatus;
  final SaveWatchlistTv _saveWatchlist;
  final RemoveWatchlistTv _removeWatchlist;

  late String watchlistMessage = "";

  TvDetailWatchlistCubit(
      this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist)
      : super(TvDetailWatchlistEmpty()) {
  }

  Future<void> watchlistStatus(int tvDetailId) async {
    emit(TvDetailWatchlistLoading());

    final isAddedToWatchlist = await _getWatchListStatus.execute(tvDetailId);

    emit(TvDetailWatchlistHasData(isAddedToWatchlist));
  }

  Future<void> saveWatchlist(TvDetail tvDetail) async {
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
  }

  Future<void> removeWatchlist(TvDetail tvDetail) async {
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
  }
}
