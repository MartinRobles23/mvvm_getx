import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mvvm_getx/data/remote/models/model.dart';
import 'package:mvvm_getx/data/remote/repositories/app_repository_impl.dart';
import 'package:mvvm_getx/data/response/response_status.dart';
import 'package:mvvm_getx/ui/viewModels/view_model.dart';

import 'view_model_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AppRepositoryImpl>()])
// Run: dart run build_runner build

void main() {
  late AppRepositoryImpl repo;
  late ViewModel viewModel;

  setUp(() {
    repo = MockAppRepositoryImpl();
    viewModel = ViewModel(repo);
  });

  final postTest = Model(
    id: 123,
    body: 'body',
    title: 'Post title',
    userId: 231231,
  );

  group('ViewModel', () {
    test('getData viewModel -> State Loading', () async {
      Get.put(ViewModel(repo));

      when(repo.getData())
          .thenAnswer((realInvocation) async => Future.value([]));

      viewModel.getData();
      final response = viewModel.baseResponse.value.obs.value;
      expect(response.status, equals(Status.LOADING));
      expect(response.error, equals(null));
      expect(response.data, equals(null));
    });

    test('getData viewModel -> State Success', () async {
      Get.put(ViewModel(repo));

      when(repo.getData())
          .thenAnswer((realInvocation) async => Future.value([postTest]));

      viewModel.getData();
      await Future.delayed(const Duration(milliseconds: 500));

      final response = viewModel.baseResponse.value.obs.value;
      expect(response.status, equals(Status.SUCCESS));
      expect(response.data, isA<List<Model>>());
      expect(response.error, equals(null));
      expect(response.data!.length, equals(1));
      expect(response.data![0].id, equals(123));
    });

    test('getData viewModel -> State Failure', () async {
      Get.put(ViewModel(repo));

      when(repo.getData())
          // ignore: null_argument_to_non_null_type
          .thenAnswer((realInvocation) async => Future.value(null));

      viewModel.getData();
      await Future.delayed(const Duration(milliseconds: 500));

      final response = viewModel.baseResponse.value.obs.value;
      expect(response.status, equals(Status.FAILURE));
      expect(response.data, equals(null));
      expect(response.error, isA<Exception>());
      // print(response.toString());
    });
  });
}
