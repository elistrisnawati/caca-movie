import 'package:dartz/dartz.dart';
import 'package:module_generic/common/failure.dart';
import 'package:module_tv/domain/entities/tv/tv.dart';
import 'package:module_tv/domain/repositories/tv/tv_repository.dart';

class GetTopRatedTvs {
  final TvRepository repository;

  GetTopRatedTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTopRatedTvs();
  }
}
