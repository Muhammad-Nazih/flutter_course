import 'package:bloc/bloc.dart';
import 'package:first_pro/models/shop_app/shop_login_model.dart';
import 'package:first_pro/modules/shop_app/register/cubit/states.dart';
import 'package:first_pro/shared/network/end_points.dart';
import 'package:first_pro/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister({
    required String name, 
    required String email,
    required String password,
    required String phone,
    }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(url: REGISTER, data: {
      'name': name, 
      'email': email,
      'password': password,
      'phone': phone,
      })
        .then((value) {
          print(value.data);
          loginModel = ShopLoginModel.fromJson(value.data);
          emit(ShopRegisterSuccessState(loginModel!));
        })
        .catchError((error) {
          emit(ShopRegisterErrorState(error));
        });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
