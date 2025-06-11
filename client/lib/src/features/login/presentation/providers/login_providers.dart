import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:house_rental_flutter/src/core/network/dio_provider.dart';
import 'package:house_rental_flutter/src/features/auth/data/models/models.dart';
import 'package:house_rental_flutter/src/features/auth/presentation/providers/auth_provider.dart';
import 'package:house_rental_flutter/src/features/login/application/login_service.dart';
import 'package:house_rental_flutter/src/features/login/data/repositories/login_repository_impl.dart';
import 'package:house_rental_flutter/src/features/login/data/data_sources/login_remote_data_source.dart'; // add your data source import
import 'package:house_rental_flutter/src/features/login/domain/usecases/login_usecase.dart';

// Provide the remote data source
final loginRemoteDataSourceProvider = Provider<LoginRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return LoginRemoteDataSourceImpl(dio: dio);
});


// Provide the repository with remote data source injected
final loginRepositoryProvider = Provider<LoginRepositoryImpl>((ref) {
  final remoteDataSource = ref.read(loginRemoteDataSourceProvider);
  return LoginRepositoryImpl(remoteDataSource: remoteDataSource);
});

// Provide the use case
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.read(loginRepositoryProvider);
  return LoginUseCase(repository);
});

// Provide the service
final loginServiceProvider = Provider<LoginService>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  return LoginService(loginUseCase: loginUseCase);
});

// StateNotifierProvider for Login UI state
final loginStateProvider =
    StateNotifierProvider<LoginNotifier, AsyncValue<Map<String, dynamic>?>>(
  (ref) => LoginNotifier(ref.read(loginServiceProvider), ref),
);

class LoginNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>?>> {
  final LoginService _loginService;
  final Ref _ref;

  LoginNotifier(this._loginService, this._ref)
      : super(const AsyncValue.data(null));

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    print('Login started for $email');

    final result = await _loginService.login(email: email, password: password);

    result.fold(
      (failure) {
        // print('Login failed: $failure');
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (data) {
        print('Raw login data: $data');
        print('Data runtimeType: ${data.runtimeType}');
        state = AsyncValue.data(data);
        try {
          final token = data['token'];
          User user = data['user'];
          print('Token: $token');
          print('User: $user');

          _ref.read(authNotifierProvider.notifier).login(token, user);
        } catch (e, stack) {
          print('Error accessing token/user: $e');
          print(stack);
          state = AsyncValue.error(e, stack);
        }
      },
    );
  }
}

