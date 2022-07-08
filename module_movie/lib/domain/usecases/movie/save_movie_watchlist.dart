import 'package:dartz/dartz.dart';
import 'package:module_generic/common/failure.dart';
import 'package:module_movie/domain/entities/movie/movie_detail.dart';
import 'package:module_movie/domain/repositories/movie/movie_repository.dart';

class SaveWatchlistMovie {
  final MovieRepository movieRepository;

  SaveWatchlistMovie(
    this.movieRepository,
  );

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return movieRepository.saveWatchlist(movie);
  }
}
