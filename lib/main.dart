import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_pro/layout/news_app/cubit/cubit.dart';
import 'package:first_pro/layout/news_app/news_layout.dart';
import 'package:first_pro/layout/shop_app/cubit/cubit.dart';
import 'package:first_pro/layout/shop_app/shop_layout.dart';
import 'package:first_pro/layout/social_app/cubit/cubit.dart';
import 'package:first_pro/layout/social_app/social_layout.dart';
import 'package:first_pro/layout/todo_app/todo_layout.dart';
import 'package:first_pro/modules/counter_app/counter/counter_screen.dart';
import 'package:first_pro/modules/news_app/web_view/web_view_screen.dart';
import 'package:first_pro/modules/shop_app/login/shop_login_screen.dart';
import 'package:first_pro/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:first_pro/modules/social_app/social_login/social_login_screen.dart';
import 'package:first_pro/shared/bloc_observer.dart';
import 'package:first_pro/shared/components/constants.dart';
import 'package:first_pro/shared/cubit/cubit.dart';
import 'package:first_pro/shared/cubit/states.dart';
import 'package:first_pro/shared/network/local/cache_helper.dart';
import 'package:first_pro/shared/network/remote/dio_helper.dart';
import 'package:first_pro/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

String? token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();
  DioHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  //bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  //token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'uId');

  // if (onBoarding != null) {
  //   if (token != null)
  //     widget = ShopLayout();
  //   else
  //     widget = ShopLoginScreen();
  // } else {
  //   widget = OnBoardingScreen();
  // }

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(
    MyApp(
      // isDark: isDark!,
      startWidget: widget,
    ),
  );
}

class MyApp extends StatelessWidget {
  // final bool isDark;
  final Widget startWidget;

  MyApp({
    // required this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  NewsCubit()
                    ..getBusiness()
                    ..getSports()
                    ..getScience(),
        ),
        BlocProvider(create: (context) => AppCubit()..changeAppMode()),
        BlocProvider(
          create:
              (context) =>
                  ShopCubit()
                    ..getHomeData()
                    ..getCategories()
                    ..getFavorites()
                    ..getUserData(),
        ),
        BlocProvider(create: (context) => SocialCubit()..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            // AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}


// theme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: Colors.teal,
      //     brightness: Brightness.light,
      //   ),
      //   // Explicitly set app bar color (M3 sometimes needs this)
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: ColorScheme.fromSeed(seedColor: Colors.teal).primary,
      //   ),
      // ),