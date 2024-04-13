import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../constants/strings.dart';
import '../../../../core/error/error_handler.dart';
import '../../../../core/network/network_info.dart';
import '../../../../data/Model/user/searchUser/searchUserDataModel.dart';
import '../../../../data/repository_impl/searchUserRepositoryImpl.dart';

part 'search_user_event.dart';

part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  SearchUserRepositoryImpl searchUserRepositoryImpl;
  final NetworkInfo networkInfo;

  ///here store list of users
  List<SearchUserData> searchResults = [];

  SearchUserBloc(this.searchUserRepositoryImpl, this.networkInfo) : super(SearchUserInitial()) {
    on<FetchUsers>((event, emit) async {
      emit(SearchUserLoadingState());
      if (await networkInfo.isConnected) {
        try {
          final data = await searchUserRepositoryImpl.searchUser(event.name);
          // print('Message is ==>  $data');
          print('Chats Userid is==>> ${data.data}');
          searchResults = data.data!;
          print("List of search data is $searchResults");

          // search();
          emit(SearchUserFinishedState(data.data!));
        }

        // on DioException catch (e) {
        //   print('Chat Status Code: ${e.response!.statusCode}');
        //   print('Chat Response Message: ${e.response!.statusMessage}');
        //   searchResults.clear();
        //   emit(SearchUserStateErrorState(e.response!.data['message']));
        // }

        catch (e) {
          emit(SearchUserStateErrorState(ErrorHandler.handle(e).failure.message));
        }
      } else {
        return emit(SearchUserStateErrorState((AppStrings.noInternetError)));
      }
    });

    on<ClearUserFromSearchtxt>(
      (event, emit) {
        searchResults.clear();
        emit(ClearUserSearchState());
      },
    );
  }
}
