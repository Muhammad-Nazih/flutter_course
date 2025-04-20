import 'package:first_pro/layout/shop_app/shop_layout.dart';
import 'package:first_pro/main.dart';
import 'package:first_pro/modules/shop_app/register/cubit/cubit.dart';
import 'package:first_pro/modules/shop_app/register/cubit/states.dart';
import 'package:first_pro/shared/components/components.dart';
import 'package:first_pro/shared/network/local/cache_helper.dart';
import 'package:first_pro/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({super.key});

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);

              showToast(
                text: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
          appBar: AppBar(),
          body: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'REGISTER',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              'Register now to browse our hot offers',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                            ),
                            SizedBox(height: 30.0),
                            defaultFormField(
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'plaese enter your name';
                                }
                              },
                              label: 'User Name',
                              prefix: Icons.person,
                            ),
                            SizedBox(height: 15.0),
                            defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'plaese enter your Email Address';
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email,
                            ),
                            SizedBox(height: 15.0),
                            defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: ShopRegisterCubit.get(context).suffix,
                              onSubmit: (value) {
                                
                              },
                              isPassword: ShopRegisterCubit.get(context).isPassword,
                              suffixPressed: () {
                                ShopRegisterCubit.get(
                                  context,
                                ).changePasswordVisibility();
                              },
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'password is too short';
                                }
                              },
                              label: 'Password',
                              prefix: Icons.lock_outline,
                            ),
                            SizedBox(height: 15.0),
                            defaultFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'plaese enter your Phone Number';
                                }
                              },
                              label: 'Phone Number',
                              prefix: Icons.phone,
                            ),
                            SizedBox(height: 30.0),
                            state is! ShopRegisterLoadingState
                                ? defaultButton(
                                  width: double.infinity,
                                  background: defaultColor,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopRegisterCubit.get(context).userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  text: 'Register',
                                  )
                                : Center(child: CircularProgressIndicator()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        );
        },
      ),
    );
  }
}