import 'package:bloc/bloc.dart';
import 'package:lets_chatapp/data/Model/chat/getAll_chat.dart';
import 'package:lets_chatapp/data/Model/chat/get_single_chat.dart';
import 'package:lets_chatapp/data/repository_impl/getAllChatRepositoryImpl.dart';
import 'package:meta/meta.dart';
import '../../../../core/error/error_handler.dart';
part 'get_all_chat_state.dart';

class GetAllChatCubit extends Cubit<GetAllChatState> {
  GetAllChatRepositoryImpl getAllChatRepositoryImpl;

  GetAllChatCubit(this.getAllChatRepositoryImpl) : super(GetAllChatInitial());

  getChat() async {
    emit(GetAllChatLoadingState());
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
  }

  getSingleChat(String chatID) async {
    try {
      final data = await getAllChatRepositoryImpl.getSingleChat(chatID);
      print('Message of get singlechat is ==>  ${data.msg}');
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
}
