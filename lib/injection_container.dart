import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'core/network/api_client.dart';
import 'core/network/network_info.dart';
import 'core/utils/logger/logger.dart';

final sl = GetIt.instance;

Future<void> init() async {
  AppLogger.info('🔧 Initializing dependencies...');

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl<Dio>()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl<Connectivity>()));

  // Repository implementations, use cases, etc. bu yerda ro'yxatdan o'tkaziladi
  // Masalan:
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(...));

  AppLogger.info('✅ Dependencies initialized successfully');
}