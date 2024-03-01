import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lets_chatapp/data/Model/authModel/signup_response.dart';
import 'package:lets_chatapp/domain/usecases/signup_usecase.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupUsecase signupUsecase;

  SignupBloc(this.signupUsecase) : super(SignupInitial()) {
    on<SignupUser>(registerUser);
  }

  Future<FutureOr<void>> registerUser(SignupUser event, Emitter<SignupState> emit) async {
    emit(SignupLoadingState());

    try {
      final SignupResponse data = await signupUsecase.call(
        event.name,
        event.email,
        event.password,
        event.confirmPassword,
      );
      // print(data.toString());
      print('data is ==>  ${data.accessToken}');
      emit(SignupFinishedState(data));

      // return data;
    } catch (e) {
      pragma(
        e.toString(),
      );
    }
  }
}
