import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_pro/layout/social_app/cubit/cubit.dart';
import 'package:first_pro/layout/social_app/cubit/states.dart';
import 'package:first_pro/modules/social_app/new_post/new_post_screen.dart';
import 'package:first_pro/shared/components/components.dart';
import 'package:first_pro/shared/styles/colors.dart';
import 'package:first_pro/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
