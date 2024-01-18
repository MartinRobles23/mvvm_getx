import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvvm_getx/config/constants/constants.dart';
import 'package:mvvm_getx/data/remote/models/model.dart';
import 'package:mvvm_getx/data/remote/repositories/app_repository_impl.dart';
import 'package:mvvm_getx/domain/datasources/base_api_service.dart';

import 'app_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BaseApiService>()])
// Run: dart run build_runner build

void main() {
  late BaseApiService service;
  late AppRepositoryImpl repositoryImpl;

  setUp(() {
    service = MockBaseApiService();
    repositoryImpl = AppRepositoryImpl();
    repositoryImpl.apiService = service;
  });

  final postsTest = {
    'id': 1232,
    'title': "Test title",
    'body': "body",
    'userId': 2310,
  };

  group('App repository impl', () {
    test('Get data', () async {
      when(service.getResponse(Constants.POSTS))
          .thenAnswer((realInvocation) => Future.value([postsTest]));

      final response = await repositoryImpl.getData();

      expect(response, isNotNull);
      expect(response, isA<List<Model>>());
      expect(response[0], isA<Model>());
      expect(response[0].id, equals(1232));
    });
  });
}
