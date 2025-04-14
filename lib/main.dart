import 'package:bloc/bloc.dart';
import 'package:first_pro/layout/news_app/news_layout.dart';
import 'package:first_pro/layout/shop_app/shop_layout.dart';
import 'package:first_pro/layout/todo_app/todo_layout.dart';
import 'package:first_pro/modules/counter_app/counter/counter_screen.dart';
import 'package:first_pro/modules/news_app/web_view/web_view_screen.dart';
import 'package:first_pro/modules/shop_app/login/shop_login_screen.dart';
import 'package:first_pro/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:first_pro/shared/bloc_observer.dart';
import 'package:first_pro/shared/cubit/cubit.dart';
import 'package:first_pro/shared/cubit/states.dart';
import 'package:first_pro/shared/network/local/cache_helper.dart';
import 'package:first_pro/shared/network/remote/dio_helper.dart';
import 'package:first_pro/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');  
  String token = CacheHelper.getData(key: 'token');

  Widget widget;

  // print(onBoarding);

  if(onBoarding != null){
    if(token != null) widget = ShopLayout();
    else widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
    }

  runApp(MyApp(
    // isDark: isDark!,
    startWidget: widget,
  ));
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
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
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