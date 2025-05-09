import 'package:bloc/bloc.dart';
import 'package:first_pro/models/shop_app/shop_login_model.dart';
import 'package:first_pro/modules/shop_app/login/cubit/states.dart';
import 'package:first_pro/shared/network/end_points.dart';
import 'package:first_pro/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
          print(value.data);
          loginModel = ShopLoginModel.fromJson(value.data);
          emit(ShopLoginSuccessState(loginModel!));
        })
        .catchError((error) {
          emit(ShopLoginErrorState(error));
        });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }
}
