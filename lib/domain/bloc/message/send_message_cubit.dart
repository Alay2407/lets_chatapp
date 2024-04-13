import 'package:bloc/bloc.dart';
import 'package:lets_chatapp/data/Model/message/send_message_body.dart';
import 'package:meta/meta.dart';

import '../../../constants/strings.dart';
import '../../../core/error/error_handler.dart';
import '../../../core/network/network_info.dart';
import '../../../data/Model/message/send_message.dart';
import '../../../data/repository_impl/sendMsgRepositoyImpl.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMsgRepositoryImpl sendMsgRepositoryImpl;
  final NetworkInfo networkInfo;

  SendMessageCubit(this.sendMsgRepositoryImpl, this.networkInfo) : super(SendMessageInitial());

  sendMessage(String id, SendMessageBody sendMessageBody) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await sendMsgRepositoryImpl.sendMessage(id, sendMessageBody);
        print('Message is ==>   ${data.msg}');
        // print('Chats Userid is==>> ${data.data!.chats![0].userID}');
        emit(SendMessageFinishedState(data));
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
          SendMessageErrorState(
            ErrorHandler.handle(e).failure.message,
          ),
        );
      }
    } else {
      return emit(SendMessageErrorState((AppStrings.noInternetError)));
    }
  }
}
