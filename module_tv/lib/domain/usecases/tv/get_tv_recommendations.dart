import 'package:dartz/dartz.dart';
import 'package:module_generic/common/failure.dart';
import 'package:module_tv/domain/entities/tv/tv.dart';
import 'package:module_tv/domain/repositories/tv/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
