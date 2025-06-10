// lib/features/login/presentation/providers/login_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../application/login_service.dart';
import '../../data/data_sources/login_remote_data_source.dart';
import '../../data/repositories/login_repository_impl.dart';
import '../../../login/domain/repsositories/login_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../presentation/providers/login_providers.dart';
import '../../../../core/network/dio_client.dart';

final loginRemoteDataSourceProvider = Provider<LoginRemoteDataSource>((ref) {
  final dio = ref.read(dioClientProvider);
  return LoginRemoteDataSourceImpl(dio: dio);
});

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final remoteDataSource = ref.read(loginRemoteDataSourceProvider);
  return LoginRepositoryImpl(remoteDataSource: remoteDataSource);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(loginRepositoryProvider);
  return LoginUseCase(repository);
});

final loginStateProvider =
    StateNotifierProvider<LoginNotifier, AsyncValue<Map<String, dynamic>?>>(
      (ref) => LoginNotifier(ref.read(loginServiceProvider)),
    );

class LoginNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>?>> {
  final LoginService _loginService;

  LoginNotifier(this._loginService) : super(const AsyncValue.data(null));

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();

    final result = await _loginService.login(email: email, password: password);

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (data) => AsyncValue.data(data),
    );
  }
}
