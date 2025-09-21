import 'package:get_it/get_it.dart';
import '../../data/datasources/remote/api_client.dart';
import '../../data/repositories/payment_repository_impl.dart';
import '../../domain/repositories/payment_repository.dart';
import '../../domain/use_cases/create_subscription.dart';
import '../../domain/use_cases/get_braintree_token.dart';
import '../../domain/use_cases/rent_power_bank.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Data sources
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(),
  );

  // Repositories
  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(getIt<ApiClient>()),
  );

  // Use cases
  getIt.registerLazySingleton<GetBraintreeToken>(
    () => GetBraintreeToken(getIt<PaymentRepository>()),
  );

  getIt.registerLazySingleton<CreateSubscription>(
    () => CreateSubscription(getIt<PaymentRepository>()),
  );

  getIt.registerLazySingleton<RentPowerBank>(
    () => RentPowerBank(getIt<PaymentRepository>()),
  );
}
