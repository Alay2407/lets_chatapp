import 'package:get_it/get_it.dart';
import 'package:lets_chatapp/data/repository_impl/authRepository_impl.dart';
import 'package:lets_chatapp/data/repository_impl/getAllChatRepositoryImpl.dart';
import 'package:lets_chatapp/data/repository_impl/searchUserRepositoryImpl.dart';
import 'package:lets_chatapp/domain/bloc/auth/change_pass/changepass_bloc.dart';
import 'package:lets_chatapp/domain/bloc/auth/login_bloc/login_bloc.dart';
import 'package:lets_chatapp/domain/bloc/auth/signup_bloc/signup_bloc.dart';
import 'package:lets_chatapp/domain/bloc/chat/getAllChat/get_all_chat_cubit.dart';
import 'package:lets_chatapp/domain/bloc/searchUser/new/search_user_bloc.dart';
import 'package:lets_chatapp/domain/usecases/change_usecase.dart';
import 'package:lets_chatapp/domain/usecases/login_usecase.dart';
import 'package:lets_chatapp/domain/usecases/signup_usecase.dart';
import 'package:dio/dio.dart';
import 'core/shared_preferences/SharedPreferenceHelper.dart';
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
  locator.registerFactory(
    () => ChangepassBloc(
      locator<ChangePassUsecase>(),
    ),
  );

  locator.registerFactory(() => GetAllChatCubit(
        locator<GetAllChatRepositoryImpl>(),
      ));

  locator.registerFactory(() => SearchUserBloc(
        locator<SearchUserRepositoryImpl>(),
      ));
  //Repository

  locator.registerLazySingleton<AuthRepositoryimpl>(
    () => AuthRepositoryimpl(),
  );

  locator.registerLazySingleton<SignupUsecase>(
    () => SignupUsecase(
      locator<AuthRepositoryimpl>(),
    ),
  );
  locator.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      locator<AuthRepositoryimpl>(),
    ),
  );

  locator.registerLazySingleton<ChangePassUsecase>(
    () => ChangePassUsecase(
      locator<AuthRepositoryimpl>(),
    ),
  );

  locator.registerLazySingleton<GetAllChatRepositoryImpl>(
    () => GetAllChatRepositoryImpl(),
  );

  locator.registerLazySingleton<SearchUserRepositoryImpl>(
    () => SearchUserRepositoryImpl(),
  );

  //shared Preference
  SharedPreferences prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferenceHelper>(
    SharedPreferenceHelper(prefs: prefs),
  );

  //Data Source
  locator.registerSingleton<RetrofitClient>(RetrofitClient(Dio()));
}
