import 'package:first_pro/layout/shop_app/cubit/states.dart';
import 'package:first_pro/models/shop_app/home_model.dart';
import 'package:first_pro/modules/shop_app/categories/categories_screen.dart';
import 'package:first_pro/modules/shop_app/favorites/favorites_screen.dart';
import 'package:first_pro/modules/shop_app/products/products_screen.dart';
import 'package:first_pro/modules/shop_app/settings/settings_screen.dart';
import 'package:first_pro/shared/components/constants.dart';
import 'package:first_pro/shared/network/end_points.dart';
import 'package:first_pro/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
      ).then((value) {
          homeModel = HomeModel.fromJson(value.data);
          print(homeModel!.data!.banners[0].image);
          print(homeModel!.status);
          // printFullText(homeModel.toString());
          emit(ShopSuccessHomeDataState());
        })
        .catchError((error) {
          print(error.toString());
          emit(ShopErrorHomeDataState());
        });
  }
}
