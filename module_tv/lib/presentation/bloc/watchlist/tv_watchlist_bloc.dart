import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:module_tv/domain/entities/tv/tv.dart';
import 'package:module_tv/domain/usecases/tv/get_watchlist_tvs.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class WatchlistTvsBloc extends Bloc<WatchlistTvsEvent, WatchlistTvsState> {
  final GetWatchlistTvs _getWatchlistTvs;

  WatchlistTvsBloc(this._getWatchlistTvs) : super(WatchlistTvsEmpty()) {
    on<OnRequested>(
      (event, emit) async {
        emit(WatchlistTvsLoading());
        final result = await _getWatchlistTvs.execute();

        result.fold(
          (failure) {
            emit(WatchlistTvsError(failure.message));
          },
          (data) {
            emit(WatchlistTvsHasData(data));
          },
        );
      },
    );
  }
}
