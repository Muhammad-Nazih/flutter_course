import 'package:bloc/bloc.dart';
import 'package:first_pro/modules/shop_app/login/cubit/states.dart';
import 'package:first_pro/shared/network/end_points.dart';
import 'package:first_pro/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {

  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {

    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url: LOGIN, 
      data: 
      {
        'email':'',
        'password':'',
      },
      ).then((value){
        print(value.data);
        emit(ShopLoginSuccessState());
      }).catchError((error)
      {
        emit(ShopLoginErrorState(error));
      });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
void changePasswordVisibilit(){
  
  isPassword = !isPassword;
  suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

  emit(ShopChangePasswordVisibilityState());
}
}