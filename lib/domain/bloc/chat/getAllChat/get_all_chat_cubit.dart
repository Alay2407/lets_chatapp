import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:lets_chatapp/data/Model/chat/getAll_chat.dart';
import 'package:lets_chatapp/data/Model/user/getSingleUser/getSingleUserModel.dart';
import 'package:lets_chatapp/data/repository_impl/getAllChatRepositoryImpl.dart';
import 'package:meta/meta.dart';
import '../../../../constants/strings.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../../../data/Model/chat/get_single_chat.dart';
import '../../../../data/Model/chat/get_single_chat_data.dart';

part 'get_all_chat_state.dart';

class GetAllChatCubit extends Cubit<GetAllChatState> {
  GetAllChatRepositoryImpl getAllChatRepositoryImpl;

  GetAllChatCubit(this.getAllChatRepositoryImpl,this.networkInfo) : super(GetAllChatInitial());
  final NetworkInfo networkInfo;
  ///getAll Chat api calling
  getChat() async {
    emit(GetAllChatLoadingState());
    if (await networkInfo.isConnected){

      try {
        final data = await getAllChatRepositoryImpl.getAllChat();
        print('Message is ==>  ${data.msg}');
        // print('Chats Userid is==>> ${data.data!.chats![0].userID}');
        emit(GetAllChatFinishedState(data));
        // emit(ChangepassFinishedState(data));
      }

      // on DioException catch (e) {
      //   print('Chat Status Code: ${e.response!.statusCode}');
      //   print('Chat Response Message: ${e.response!.statusMessage}');
      //   emit(GetAllChatErrorState(e.response!.data['message']));
      //
      //   // emit(ChangepassErrorState(e.response!.statusMessage));
      //   // print('Response error: ${e.sta}');
      // }
      catch (e) {
        emit(
          GetAllChatErrorState(
            ErrorHandler.handle(e).failure.message,
          ),
        );
      }
    }else{
      return  emit(GetAllChatErrorState((AppStrings.noInternetError)));
    }
  }

  ///get Single chat api
  getSingleChat(chatID) async {
    if (await networkInfo.isConnected) {
      emit(GetSingleChatLoadingState());
      try {
        final data = await getAllChatRepositoryImpl.getSingleChat(chatID);
        // print('Message of get singlechat is ==>  ${data.data![1].id}');
        // print('Chats Userid is==>> ${data.data!.chats![0].userID}');
        emit(GetSingleChatFinishedState(data));
        // emit(ChangepassFinishedState(data));
      }

      // on DioException catch (e) {
      //   print('Chat Status Code: ${e.response!.statusCode}');
      //   print('Chat Response Message: ${e.response!.statusMessage}');
      //   emit(GetAllChatErrorState(e.response!.data['message']));
      //
      //   // emit(ChangepassErrorState(e.response!.statusMessage));
      //   // print('Response error: ${e.sta}');
      // }

      catch (e) {
        emit(
          GetSingleChatErrorState(
            ErrorHandler.handle(e).failure.message,
          ),
        );
      }
    }
    else {
      return emit(GetSingleChatErrorState((AppStrings.noInternetError)));
    }
  }

  ///Get Single user
  getSingleUser(emailID) async {
    if (await networkInfo.isConnected)  {
      try {
        final data = await getAllChatRepositoryImpl.getSingleUser(emailID);
        print('Message of get singleuser is ==>  $data');
        // print('Chats Userid is==>> ${data.data!.chats![0].userID}');
        emit(GetSingleUserFinishedState(data));
        // emit(ChangepassFinishedState(data));
      }

      // on DioException catch (e) {
      //   print('Chat Status Code: ${e.response!.statusCode}');
      //   print('Chat Response Message: ${e.response!.statusMessage}');
      //   emit(GetAllChatErrorState(e.response!.data['message']));
      //
      //   // emit(ChangepassErrorState(e.response!.statusMessage));
      //   // print('Response error: ${e.sta}');
      // }

      catch (e) {
        emit(
          GetSingleUserErrorState(
            ErrorHandler.handle(e).failure.message,
          ),
        );
      }
    }
    else {
      return emit(GetSingleUserErrorState((AppStrings.noInternetError)));
    }
  }
}
