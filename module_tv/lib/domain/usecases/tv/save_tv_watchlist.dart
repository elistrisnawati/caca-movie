import 'package:dartz/dartz.dart';
import 'package:module_generic/common/failure.dart';
import 'package:module_tv/domain/entities/tv/tv_detail.dart';
import 'package:module_tv/domain/repositories/tv/tv_repository.dart';

class SaveWatchlistTv {
  final TvRepository tvRepository;

  SaveWatchlistTv(
    this.tvRepository,
  );

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return tvRepository.saveWatchlist(tv);
  }
}
