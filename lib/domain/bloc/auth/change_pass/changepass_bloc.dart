import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/Model/authModel/login_data.dart';
import '../../../usecases/change_usecase.dart';
import 'package:dio/dio.dart';

part 'changepass_event.dart';

part 'changepass_state.dart';

class ChangepassBloc extends Bloc<ChangepassEvent, ChangepassState> {
  ChangePassUsecase changePassUsecase;

  ChangepassBloc(this.changePassUsecase) : super(ChangepassInitial()) {
    on<Changepass>((event, emit) async {
      emit(ChangepassLoadingState());
      try {
        final data = await changePassUsecase.call(
          event.currentPassword,
          event.newPassword,
        );

        print('sdfsfs');
        print('data is ==>  ${data.email}');
        print('name is ==>  ${data.name}');

        // await sharedPrefLocator.setValues(
        //   key: 'id',
        //   value: data.id.toString(),
        // );

        emit(ChangepassFinishedState(data));
      } on DioException catch (e) {
        print('Change Status Code: ${e.response!.statusCode}');
        print('Change Response Message: ${e.response!.statusMessage}');

        emit(ChangepassErrorState(e.response!.statusMessage));
        // print('Response error: ${e.sta}');
      }
    });
  }
}
