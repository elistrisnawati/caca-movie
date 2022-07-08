import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:module_movie/data/datasources/db/database_helper_movie.dart';
import 'package:module_movie/data/datasources/movie/movie_local_data_source.dart';
import 'package:module_movie/data/datasources/movie/movie_remote_data_source.dart';
import 'package:module_movie/domain/repositories/movie/movie_repository.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelperMovie,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
