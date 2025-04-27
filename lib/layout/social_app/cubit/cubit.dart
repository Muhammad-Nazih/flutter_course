import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_pro/layout/shop_app/cubit/states.dart';
import 'package:first_pro/layout/social_app/cubit/states.dart';
import 'package:first_pro/models/social_app/social_user_model.dart';
import 'package:first_pro/modules/social_app/settings/settings_screen.dart';
import 'package:first_pro/modules/social_app/chats/chats_screen.dart';
import 'package:first_pro/modules/social_app/feeds/feeds_screen.dart';
import 'package:first_pro/modules/social_app/users/users_screen.dart';
import 'package:first_pro/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
          // print(value.data());
          userModel = SocialUserModel.fromJson(value.data()!);
          emit(SocialGetUserSuccessState());
        })
        .catchError((error) {
          print(error.toString());
          emit(SocialGetUserErrorState(error.toString()));
        });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    Container(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = ['Home', 'Chats', '', 'Users', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  final ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }



  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref
              .getDownloadURL()
              .then((value) {
                // emit(SocialUploadProfileImageSuccessState());
                print(value);
                updateUser(
                  name: name, 
                  phone: phone, 
                  bio: bio,
                  image: value,
                  );
              })
              .catchError((error) {
                emit(SocialUploadProfileImageErrorState());
              });
        })
        .catchError((error) {
          emit(SocialUploadProfileImageErrorState());
        });
  }


  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) 
  {
    emit(SocialUserUpdateLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
          value.ref
              .getDownloadURL()
              .then((value) {
                //emit(SocialUploadCoverImageSuccessState());
                print(value);
                updateUser(
                  name: name, 
                  phone: phone, 
                  bio: bio,
                  cover: value,
                  );
              })
              .catchError((error) {
                emit(SocialUploadCoverImageErrorState());
              });
        })
        .catchError((error) {
          emit(SocialUploadCoverImageErrorState());
        });
  }


  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  })
  {
    SocialUserModel model = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
      email: userModel!.email,
      uId: userModel!.uId,
      isEmailVerified: false,
    );


    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
          getUserData();
        })
        .catchError((error) {
          emit(SocialUserUpdateErrorState());
        });
  }


  File? postImage;

  Future<void> getPostImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }


  void createNewPost({
    required String name,
    required String uId,
    required String image,
    required String dateTime,
    required String text,
  }) 
  {
    emit(SocialCreatePostLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
          value.ref
              .getDownloadURL()
              .then((value) {
                //emit(SocialUploadCoverImageSuccessState());
                print(value);
                
              })
              .catchError((error) {
                emit(SocialCreatePostErrorState());
              });
        })
        .catchError((error) {
          emit(SocialCreatePostErrorState());
        });
  }
}



  // void updateUserImages() 
  // {
  //   emit(SocialUserUpdateLoadingState());
  //   if(coverImage != null)
  //   {
  //     uploadCoverImage();
  //   } else if(profileImage != null)
  //   {
  //     uploadProfileImage();
  //   } else if(coverImage != null && profileImage != null)
  //   {

  //   } else
  //   {

  //   }

    
  // }