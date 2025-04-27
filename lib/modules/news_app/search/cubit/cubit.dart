import 'package:first_pro/models/shop_app/search_model.dart';
import 'package:first_pro/modules/news_app/search/cubit/states.dart';
import 'package:first_pro/shared/components/constants.dart';
import 'package:first_pro/shared/network/end_points.dart';
import 'package:first_pro/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  //Here we can remove the late and add ? instead in front of SearchModel
  late SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH, 
      data: {'text':text},
      token: token,
      )
        .then((value) {
          model = SearchModel.fromJson(value.data);

          emit(SearchSuccessState());
        })
        .catchError((error) {
          emit(SearchErrorState());
        });
  }
}
