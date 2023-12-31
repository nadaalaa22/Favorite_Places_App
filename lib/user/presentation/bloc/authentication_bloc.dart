import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../../data/datasorce/authentication_remote_ds/authentication.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRemoteDS authenticationRemoteDS;

  AuthenticationBloc(this.authenticationRemoteDS) : super(UnAuthorized()) {
    on<AuthenticationEvent>((event, emit) async {
      try {
        if (event is SignInEvent) {
          emit(LoadingState());
          await authenticationRemoteDS.signIn(event.email, event.password);
          emit(Authorized());
        } else if (event is SignUpEvent) {
          emit(LoadingState());
          await authenticationRemoteDS.signUp(event.email, event.password);
          emit(Authorized());
        } else if (event is SignOutEvent) {
          emit(LoadingState());
          await authenticationRemoteDS.signOut();
          emit(UnAuthorized());
        }else if (event is CheckIfAuthEvent)
          {
            emit(LoadingState());
             bool isAuth = authenticationRemoteDS.checkIfAuth();
             emit(isAuth?Authorized():UnAuthorized());
          }
      } catch (error) {
        Fluttertoast.showToast(
          msg: 'invalid data',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print('nada ad aya');
        emit(AuthError(error: error.toString()));

      }
    });
  }
}
