import 'package:first_pro/layout/news_app/cubit/cubit.dart';
import 'package:first_pro/layout/news_app/cubit/states.dart';
import 'package:first_pro/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).science;
        return articleBuilder(list, context);
      },
    );
  }
}
