part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class GetUserEvent extends UserEvent {}

class SetUserEvent extends UserEvent {
  final User user;

  SetUserEvent({required this.user});
}
