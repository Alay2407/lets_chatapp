import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lets_chatapp/data/Model/authModel/data.dart';
import 'package:lets_chatapp/data/Model/authModel/signup_response.dart';
import 'package:lets_chatapp/domain/usecases/signup_usecase.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/error_handler.dart';

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
    }

    // on DioException catch (e) {
    //   print("Response message is ${e.response!.data.toString()}");
    //   print("Response status is ${e.response!.statusCode.toString()}");
    //   emit(SignupErrorState(e.response!.data['message']));
    // }

    catch (e) {
      emit(SignupErrorState(ErrorHandler.handle(e).failure.message));
    }
  }
}
