import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';

import '../features/auth/data/repositories/auth_repository.dart';
import '../features/home/data/repositories/listing_repository.dart';

import '../features/home/presentation/bloc/home_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDi() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // Network
  getIt.registerLazySingleton(() => ApiClient(getIt()));

  // Repositories
  getIt.registerLazySingleton(() => AuthRepository(getIt(), getIt()));
  getIt.registerLazySingleton(() => ListingRepository(getIt()));

  // BLoCs / Cubits
  getIt.registerFactory(() => HomeCubit(getIt()));
}
