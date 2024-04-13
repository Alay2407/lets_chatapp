
import 'package:bloc/bloc.dart';
import 'package:lets_chatapp/data/Model/authModel/login_data.dart';
import 'package:lets_chatapp/domain/usecases/login_usecase.dart';
import 'package:meta/meta.dart';

import '../../../../constants/strings.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/shared_preferences/SharedPreferenceHelper.dart';
import '../../../../getit_injector.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginUseCase loginUseCase;
  final sharedPrefLocator = locator.get<SharedPreferenceHelper>();
  final NetworkInfo networkInfo;

  LoginBloc(this.loginUseCase, this.networkInfo) : super(LoginInitial()) {
    on<LoginUser>((event, emit) async {
      if (await networkInfo.isConnected) {
        emit(LoginLoadingState());
        try {
          final data = await loginUseCase.call(
            event.email,
            event.password,
          );

          print('sdfsfs');
          print('data is ==>  ${data.email}');
          print('name is ==>  ${data.name}');

          await sharedPrefLocator.setValues(
            key: 'id',
            value: data.id.toString(),
          );

          emit(LoginFinishedState(data));
        }

        // on DioException catch (e) {
        //   print('Api Status Code: ${e.response!.statusCode}');
        //   print('Api Response Message: ${e.response!.statusMessage}');
        //
        //   emit(LoginErrorState(e.response!.data['message']));
        //   // print('Response error: ${e.sta}');
        // }

        catch (e) {
          print('Errpr handler ${ErrorHandler.handle(e).failure.message}');
          emit(LoginErrorState(ErrorHandler.handle(e).failure.message));
        }
      } else {
        return emit(LoginErrorState((AppStrings.noInternetError)));
      }
    });
  }
}
