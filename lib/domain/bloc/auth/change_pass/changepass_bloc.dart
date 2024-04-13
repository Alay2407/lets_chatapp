import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../constants/strings.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../../../data/Model/authModel/login_data.dart';
import '../../../usecases/change_usecase.dart';
import 'package:dio/dio.dart';

part 'changepass_event.dart';

part 'changepass_state.dart';

class ChangepassBloc extends Bloc<ChangepassEvent, ChangepassState> {
  ChangePassUsecase changePassUsecase;
  final NetworkInfo networkInfo;
  ChangepassBloc(this.changePassUsecase,this.networkInfo) : super(ChangepassInitial()) {
    on<Changepass>((event, emit) async {
      emit(ChangepassLoadingState());
      if (await networkInfo.isConnected)  {
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
        }

        // on DioException catch (e) {
        //   print('Change Status Code: ${e.response!.statusCode}');
        //   print('Change Response Message: ${e.response!.data['message']}');
        //
        //   //
        //   // if(e.response!.data['message'] != null){
        //   //   emit(ChangepassErrorState(e.response!.data['message']));
        //   // }
        //   // else{
        //
        //   List<dynamic> messages = e.response!.data['message'];
        //     emit(ChangepassErrorState(messages.first['msg']));
        //   // }
        //
        //   // emit(ChangepassErrorState(ErrorHandler.handle(e).failure.message.toString()));
        //   // print('Response error: ${e.sta}');
        // }
        catch (e) {
          emit(
            ChangepassErrorState(
              ErrorHandler.handle(e).failure.message.toString(),
            ),
          );
        }
      }else {
        return emit(ChangepassErrorState((AppStrings.noInternetError)));
      }
    });
  }
}
