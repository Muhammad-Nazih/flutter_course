import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_pro/models/social_app/social_user_model.dart';
import 'package:first_pro/modules/social_app/social_register/cubit/states.dart';
import 'package:first_pro/shared/network/end_points.dart';
import 'package:first_pro/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          // print(value.user!.email);
          // print(value.user!.uid);
          userCreate(
            email: email,
            name: name,
            phone: phone,
            uId: value.user!.uid,
          );
        })
        .catchError((error) {
          emit(SocialRegisterErrorState(error.toString()));
        });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      image: 'https://img.freepik.com/free-photo/glad-happy-man-makes-okay-gesture-shows-that-everything-is-fine-tells-be-calm-gestures-indoor-against-white-wall_273609-17302.jpg?t=st=1745608440~exp=1745612040~hmac=f2df5f98243af851cff068b008f60902b4e654d6592603bef36078c58b5a5e3b&w=1380',
      cover: 'https://img.freepik.com/free-photo/thanksgiving-day-meal-with-copy-space_23-2149100098.jpg?t=st=1745624856~exp=1745628456~hmac=68bf49950ad5cce195bae006f14a67a05dc96a1a967ef453a63d52e0a3bdb558&w=1380',
      bio: 'write your bio ...',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(SocialCreateUserSuccessState());
        })
        .catchError((error) {
          emit(SocialCreateUserErrorState(error.toString()));
        });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
