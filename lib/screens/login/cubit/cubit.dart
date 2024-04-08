// ignore_for_file: avoid_print, unused_local_variable, deprecated_member_use, unused_element, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors

import 'package:cubit_form/cubit_form.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/login/cubit/states.dart';
import 'package:login/models/login_model.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData iconData = Icons.remove_red_eye;
  void passwordVisibility() {
    isPassword = !isPassword;
    iconData = isPassword
        ? iconData = Icons.remove_red_eye
        : Icons.visibility_off_outlined;
    emit(LoginPasswordIsVisibilityState());
  }

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLodingState());
    DioHelper.postData(url: 'Webservice/login', data: {
      'username': email,
      'password': password,
    }).then((value) {
    
  
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
   
      print(loginModel!.message);

      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      loginModel = LoginModel.fromJson(error.response.data);
      print('888888888888888888888');

      print("error");
      emit(
        LoginErrorState(loginModel!),
      );
    });
  }
}