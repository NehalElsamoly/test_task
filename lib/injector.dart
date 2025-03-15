import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_club/core/api/base_api_consumer.dart';
import 'package:travel_club/core/api/dio_consumer.dart';
import 'package:travel_club/features/auth/cubit/cubit.dart';
import 'package:travel_club/features/auth/data/login_repo_impl.dart';
import 'package:travel_club/features/custom_upload_image/cubit/upload_image_cubit.dart';
import 'package:travel_club/features/home/cubit/home_cubit.dart';
import 'package:travel_club/features/home/data/repo/home_repo_impl.dart';
import 'package:travel_club/features/location/cubit/location_cubit.dart';
import 'package:travel_club/features/location/data/repo/location_repo_impl.dart';
import 'package:travel_club/features/main_screen/cubit/cubit.dart';
import 'package:travel_club/features/main_screen/data/repo/main_repo_impl.dart';
import 'package:travel_club/features/my_account/cubit/account_cubit.dart';
import 'package:travel_club/features/my_account/data/repo/account_repo_impl.dart';

import 'package:travel_club/features/splash/cubit/cubit.dart';
import 'package:travel_club/features/transportation/cubit/transportation_cubit.dart';
import 'package:travel_club/features/transportation/data/repo/transportation_repo_impl.dart';
import 'core/api/app_interceptors.dart';



final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////

  serviceLocator.registerFactory(() => SplashCubit());
  serviceLocator.registerFactory(
    () => MainCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => LoginCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => HomeCubit(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => AccountCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UploadImageCubit(),
  );

  serviceLocator.registerFactory(
    () => TransportationCubit(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => LocationCubit(serviceLocator()),
  );




//!-------------------------Declare Repo---------------------------
  serviceLocator.registerLazySingleton(() => LoginRepoImpl(serviceLocator()));
  serviceLocator.registerLazySingleton(() => MainRepoImpl(serviceLocator()));
  serviceLocator.registerLazySingleton(() => HomeRepoImpl(serviceLocator()));

  serviceLocator.registerLazySingleton(() => AccountRepoImpl(serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => TransportationRepoImpl(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => LocationRepoImpl(serviceLocator()));

//!-------------------------Declare Interceptors---------------------------

  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());

  ////////////////////////// SharedPref ////////////////////////
  final sharedPreferences = await SharedPreferences.getInstance();
  final storage =  const FlutterSecureStorage();

  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => storage);
  // Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
  // serviceLocator.registerLazySingleton(
  //       () => LogInterceptor(
  //     request: false,
  //     requestBody: false,
  //     requestHeader: false,
  //     responseBody: false,
  //     responseHeader: false,
  //     error: false,
  //   ),
  // );
}
