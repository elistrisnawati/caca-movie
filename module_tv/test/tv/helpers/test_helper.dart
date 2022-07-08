import 'package:http/io_client.dart';
import 'package:module_tv/data/datasources/db/database_helper_tv.dart';
import 'package:module_tv/data/datasources/tv/tv_local_data_source.dart';
import 'package:module_tv/data/datasources/tv/tv_remote_data_source.dart';
import 'package:module_tv/domain/repositories/tv/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelperTv,
], customMocks: [
  MockSpec<IOClient>(as: #MockHttpClient)
])
void main() {}
