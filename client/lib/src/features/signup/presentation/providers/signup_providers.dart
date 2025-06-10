// lib/features/signup/presentation/providers/signup_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/signup_service.dart';
import '../../data/data_sources/signup_remote_data_source.dart';
import '../../data/repositories/signup_repository_impl.dart';
import '../../domain/repositories/signup_repository.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../../../core/network/network.dart';

final signUpRemoteDataSourceProvider = Provider<SignUpRemoteDataSource>((ref) {
  final dio = ref.read(dioClientProvider);
  return SignUpRemoteDataSourceImpl(dio: dio);
});

final signUpRepositoryProvider = Provider<SignUpRepository>((ref) {
  final remoteDataSource = ref.read(signUpRemoteDataSourceProvider);
  return SignUpRepositoryImpl(remoteDataSource: remoteDataSource);
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  final repository = ref.read(signUpRepositoryProvider);
  return SignUpUseCase(repository);
});

final signUpStateProvider =
    StateNotifierProvider<SignUpNotifier, AsyncValue<String?>>(
      (ref) => SignUpNotifier(ref.read(signUpServiceProvider)),
    );

class SignUpNotifier extends StateNotifier<AsyncValue<String?>> {
  final SignUpService _signUpService;

  SignUpNotifier(this._signUpService) : super(const AsyncValue.data(null));

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    String? phoneNumber,
  }) async {
    state = const AsyncValue.loading();

    final result = await _signUpService.signUp(
      fullName: fullName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phoneNumber: phoneNumber,
    );

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (message) => AsyncValue.data(message),
    );
  }
}
