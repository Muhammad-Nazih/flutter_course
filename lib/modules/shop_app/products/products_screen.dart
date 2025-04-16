import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_pro/layout/shop_app/cubit/cubit.dart';
import 'package:first_pro/layout/shop_app/cubit/states.dart';
import 'package:first_pro/models/shop_app/categories_model.dart';
import 'package:first_pro/models/shop_app/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context){
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null
        ? builderWidget(ShopCubit.get(context).homeModel!, ShopCubit.get(context).categoriesModel!) 
        : Center(child: CircularProgressIndicator(),
        );
      },
      );
  }

  Widget builderWidget(HomeModel model, CategoriesModel categoriesModel) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: 
            model.data!.banners.map((e) => Image(
              image: NetworkImage('${e.image}'),
              width: double.infinity,
              // fit: BoxFit.cover,
              ),).toList(),
          
          options: CarouselOptions(
            height: 250.0,
            initialPage: 0,
            viewportFraction: 1.0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal, 
          ),
          ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data!.data![index]), 
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ), 
                  itemCount: categoriesModel.data!.data!.length,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1 / 1.7,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
          children: List.generate(model.data!.products.length, (index) => buildGridProduct(model.data!.products[index])),
          ),
        ),  
      ],
    ),
  );


  Widget buildCategoryItem(DataModel model) => Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(image: NetworkImage(model.image!),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black.withOpacity(0.8),
              width: 100.0,
              child: Text(
                model.name!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ), 
          ],
        );

  Widget buildGridProduct(ProductModel model) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        Image(
                          image: NetworkImage(model.image!),
                          width: double.infinity,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                        if(model.discount != 0) 
                        Container(
                          color: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'DISCOUNT',
                            style: TextStyle(
                              fontSize: 8.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.3,
                      ),
                      ),
                    Row(
                      children: [
                        Text(
                          '${model.price.round()}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.deepOrange,
                          ),
                          ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if(model.discount != 0) 
                          Text(
                          '${model.oldPrice.round()}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                          ),
                        Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: (){}, 
                          icon: Icon(Icons.favorite_border,))  
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
  );
}