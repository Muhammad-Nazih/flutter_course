import 'package:first_pro/modules/news_app/search/cubit/cubit.dart';
import 'package:first_pro/modules/news_app/search/cubit/states.dart';
import 'package:first_pro/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                      onSubmit: (String text) {
                        SearchCubit.get(context).search(text);
                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    SizedBox(height: 10.0),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(height: 10.0),
                    if (state is SearchSuccessState)
                      Builder(builder: (context) {
                        final rawProducts = SearchCubit.get(context).model?.data?.data ?? [];
                        final products = rawProducts
                            .where((product) =>
                                product.image != null &&
                                product.name != null &&
                                product.price != null &&
                                product.id != null)
                            .toList();

                        return Expanded(
                          child: products.isNotEmpty
                              ? ListView.separated(
                                  itemBuilder: (context, index) => buildListProduct(
                                    products[index],
                                    context,
                                    isOldPrice: false,
                                  ),
                                  separatorBuilder: (context, index) => myDivider(),
                                  itemCount: products.length,
                                )
                              : Center(child: Text('No results found')),
                        );
                      }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}