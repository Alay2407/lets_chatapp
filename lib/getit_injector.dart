import 'package:get_it/get_it.dart';
import 'package:lets_chatapp/domain/bloc/auth/login_bloc/login_bloc.dart';
import 'package:lets_chatapp/domain/bloc/auth/signup_bloc/signup_bloc.dart';
import 'package:lets_chatapp/domain/usecases/login_usecase.dart';
import 'package:lets_chatapp/domain/usecases/signup_usecase.dart';
import 'package:dio/dio.dart';
import 'core/shared_preferences/SharedPreferenceHelper.dart';
import 'data/repository_impl/login_repository_impl.dart';
import 'data/repository_impl/singup_repository_impl.dart';
import 'data/services/remote_Source/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

void init() async {
  //bloc
  locator.registerFactory(
    () => SignupBloc(
      locator<SignupUsecase>(),
    ),
  );

  locator.registerFactory(
        () => LoginBloc(
      locator<LoginUseCase>(),
    ),
  );


  //Repository
  locator.registerLazySingleton<SignupRepositoryImpl>(
    () => SignupRepositoryImpl(),
  );
  locator.registerLazySingleton<LoginRepositoryImpl>(
        () => LoginRepositoryImpl(),
  );

  //usecases
  locator.registerLazySingleton<SignupUsecase>(
    () => SignupUsecase(
      locator<SignupRepositoryImpl>(),
    ),
  );

  locator.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(
      locator<LoginRepositoryImpl>(),
    ),
  );
  //shared Preference
  SharedPreferences prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferenceHelper>(
    SharedPreferenceHelper(prefs: prefs),
  );

  //Data Source
  locator.registerSingleton<RetrofitClient>(RetrofitClient(Dio()));
}
