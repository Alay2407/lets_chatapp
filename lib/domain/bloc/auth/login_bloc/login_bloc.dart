import 'package:bloc/bloc.dart';
import 'package:lets_chatapp/data/Model/authModel/login_data.dart';
import 'package:lets_chatapp/data/Model/authModel/login_response.dart';
import 'package:lets_chatapp/domain/usecases/login_usecase.dart';
import 'package:meta/meta.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';

import '../../../../core/shared_preferences/SharedPreferenceHelper.dart';
import '../../../../data/services/AppException.dart';
import '../../../../getit_injector.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      emit(LoginLoadingState());

      try {
        final data = await loginUseCase.call(
          event.email,
          event.password,
        );

        print('sdfsfs');
        print('data is ==>  ${data.email}');
        print('name is ==>  ${data.name}');

        emit(LoginFinishedState(data));
      } on DioException catch (e) {
        print('Api Status Code: ${e.response!.statusCode}');
        print('Api Response Message: ${e.response!.statusMessage}');

        emit(LoginErrorState(e.response!.statusMessage));
        // print('Response error: ${e.sta}');
      }
    });
  }
}
