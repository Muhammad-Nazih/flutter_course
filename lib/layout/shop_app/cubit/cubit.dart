import 'package:first_pro/layout/shop_app/cubit/states.dart';
import 'package:first_pro/models/shop_app/categories_model.dart';
import 'package:first_pro/models/shop_app/change_favorites_model.dart';
import 'package:first_pro/models/shop_app/favorites_model.dart';
import 'package:first_pro/models/shop_app/home_model.dart';
import 'package:first_pro/models/shop_app/shop_login_model.dart';
import 'package:first_pro/modules/shop_app/categories/categories_screen.dart';
import 'package:first_pro/modules/shop_app/favorites/favorites_screen.dart';
import 'package:first_pro/modules/shop_app/products/products_screen.dart';
import 'package:first_pro/modules/shop_app/settings/settings_screen.dart';
import 'package:first_pro/shared/components/constants.dart';
import 'package:first_pro/shared/network/end_points.dart';
import 'package:first_pro/shared/network/local/cache_helper.dart';
import 'package:first_pro/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  String? token = CacheHelper.getData(key: 'token');

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

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token)
        .then((value) {
          homeModel = HomeModel.fromJson(value.data);

          //print(homeModel!.data!.banners[0].image);
          //print(homeModel!.status);

          homeModel?.data?.products.forEach((element) {
            favorites.addAll({element.id!: element.inFavorites!});
          });

          print(favorites.toString());

          // printFullText(homeModel.toString());
          emit(ShopSuccessHomeDataState());
        })
        .catchError((error) {
          print(error.toString());
          emit(ShopErrorHomeDataState());
        });
  }

  late CategoriesModel categoriesModel;

  void getCategories({String? token}) {
    DioHelper.getData(url: GET_CATEGORIES, token: token)
        .then((value) {
          categoriesModel = CategoriesModel.fromJson(value.data);

          emit(ShopSuccessCategoriesState());
        })
        .catchError((error) {
          print(error.toString());
          emit(ShopErrorCategoriesState());
        });
  }

  late ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    // Store current state in case we need to revert
    final currentState = favorites[productId] ?? false;

    // Optimistically update UI
    favorites[productId] = !currentState;
    // favorites[productId] = !favorites[productId]; دا اللي كان كاتبه عبدالله
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
          url: FAVORITES,
          data: {'product_id': productId},
          token: token,
        )
        .then((value) {
          changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
          print(value.data);

          if (!changeFavoritesModel.status!) {
            favorites[productId] = currentState;
          } else {
            getFavorites();
          }

          emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
        })
        .catchError((error) {
          // favorites[productId] = !favorites[productId];

          emit(ShopErrorChangeFavoritesState());
        });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVORITES, token: token)
        .then((value) {
          favoritesModel = FavoritesModel.fromJson(value.data);
          printFullText(value.data.toString());

          emit(ShopSuccessGetFavoritesState());
        })
        .catchError((error) {
          print(error.toString());
          emit(ShopErrorGetFavoritesState());
        });
  }
  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE, token: token)
        .then((value) {
          userModel = ShopLoginModel.fromJson(value.data);
          printFullText(userModel!.data!.name!);

          emit(ShopSuccessUserDataState(userModel!));
        })
        .catchError((error) {
          print(error.toString());
          emit(ShopErrorUserDataState());
        });
  }
}
