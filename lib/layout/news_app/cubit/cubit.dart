import 'package:bloc/bloc.dart';
import 'package:first_pro/layout/news_app/cubit/states.dart';
import 'package:first_pro/modules/news_app/business/business_screen.dart';
import 'package:first_pro/modules/news_app/science/science_screen.dart';
import 'package:first_pro/modules/news_app/sports/sports_screen.dart';
import 'package:first_pro/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  List<Widget> screens = [BusinessScreen(), SportsScreen(), ScienceScreen()];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'us',
            'category': 'business',
            'apikey': 'f7e952aa23e146539ca1b19ddbfacd11',
          },
        )
        .then((value) {
          //print(value.data['articles'][0]['title']);
          business = value.data['articles'];
          print(business[0]['title']);

          emit(NewsGetBusinessSuccessState());
        })
        .catchError((error) {
          print(error.toString());

          emit(NewsGetBusinessErrorState(error.toString()));
        });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country': 'us',
              'category': 'sports',
              'apikey': 'f7e952aa23e146539ca1b19ddbfacd11',
            },
          )
          .then((value) {
            //print(value.data['articles'][0]['title']);
            sports = value.data['articles'];
            print(sports[0]['title']);

            emit(NewsGetSportsSuccessState());
          })
          .catchError((error) {
            print(error.toString());

            emit(NewsGetSportsErrorState(error.toString()));
          });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country': 'us',
              'category': 'science',
              'apikey': 'f7e952aa23e146539ca1b19ddbfacd11',
            },
          )
          .then((value) {
            //print(value.data['articles'][0]['title']);
            science = value.data['articles'];
            print(science[0]['title']);

            emit(NewsGetScienceSuccessState());
          })
          .catchError((error) {
            print(error.toString());

            emit(NewsGetScienceErrorState(error.toString()));
          });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }
}
