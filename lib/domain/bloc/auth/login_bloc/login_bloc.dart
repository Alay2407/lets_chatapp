import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lets_chatapp/data/Model/authModel/login_response.dart';
import 'package:lets_chatapp/domain/usecases/login_usecase.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginUseCase loginUseCase;
  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      emit(LoginLoadingState());

      try {
        final LoginResponse data = await loginUseCase.call(
          event.email,
          event.password,
        );
        // print(data.toString());
        print('data is ==>  ${data.accessToken}');
        emit(LoginFinishedState(data));

        // return data;
      } catch (e) {
        pragma(
          e.toString(),
        );
      }
    });
  }
}
