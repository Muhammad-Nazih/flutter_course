import 'package:first_pro/layout/shop_app/cubit/cubit.dart';
import 'package:first_pro/layout/shop_app/cubit/states.dart';
import 'package:first_pro/models/shop_app/favorites_model.dart';
import 'package:first_pro/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is! ShopLoadingGetFavoritesState
            ? ListView.separated(
              itemBuilder: (context, index) => buildListProduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product, context), 
              separatorBuilder: (context, index) => myDivider(), 
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length,)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  
}
