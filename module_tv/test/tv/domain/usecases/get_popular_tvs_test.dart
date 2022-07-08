import 'package:dartz/dartz.dart';
import 'package:module_tv/domain/entities/tv/tv.dart';
import 'package:module_tv/domain/usecases/tv/get_popular_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvs usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = GetPopularTvs(mockTvRpository);
  });

  final tTvs = <Tv>[];

  group('GetPopularTvs Tests', () {
    group('execute', () {
      test(
          'should get list of tvs from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.getPopularTvs())
            .thenAnswer((_) async => Right(tTvs));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvs));
      });
    });
  });
}
