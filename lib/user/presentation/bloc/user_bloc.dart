import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/datasorce/local_datasource.dart';
import '../../data/model/user.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is SetUserEvent) {
        emit(UserLoadingState());
        await UserDataImp().setUserData(event.user);
        emit(UserLoadedState(user: event.user));
      } else if (event is GetUserEvent) {
        final userData = await UserDataImp().getUserData();
        try {
          emit(UserLoadedState(user: userData));
        } catch (e) {
          emit(UserInitial());
        }
      }
    });
  }
}
