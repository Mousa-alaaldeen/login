import '../../../../models/login_model.dart';


abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLodingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginModel model;
  LoginSuccessState(this.model);
}

class LoginErrorState extends LoginState {
  final LoginModel error;
  LoginErrorState(this.error);
}

class LoginPasswordIsVisibilityState extends LoginState {}



