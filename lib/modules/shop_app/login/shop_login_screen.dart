import 'package:first_pro/modules/shop_app/login/cubit/cubit.dart';
import 'package:first_pro/modules/shop_app/login/cubit/states.dart';
import 'package:first_pro/modules/shop_app/register/shop_register_screen.dart';
import 'package:first_pro/shared/components/components.dart';
import 'package:first_pro/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {} ,
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
                      Text('LOGIN', style: Theme.of(context).textTheme.headlineMedium),
                      Text(
                        'Login to browse our hot offers',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'plaese enter your email address';
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email_outlined,
                      ),
                      SizedBox(height: 15.0),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffix: ShopLoginCubit.get(context).suffix,
                        onSubmit: (value) {
                          if(formKey.currentState!.validate()){
                            ShopLoginCubit.get(context).userLogin(
                            email: emailController.text, 
                            password: passwordController.text,
                          );
                          }
                        },
                        isPassword: ShopLoginCubit.get(context).isPassword,
                        suffixPressed: () {
                          ShopLoginCubit.get(context).changePasswordVisibilit();
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'password is too short';
                          }
                        },
                        label: 'Password',
                        prefix: Icons.lock_outline,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      state is! ShopLoginLoadingState
                      ? defaultButton(
                        width: double.infinity, 
                        background: defaultColor, 
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            ShopLoginCubit.get(context).userLogin(
                            email: emailController.text, 
                            password: passwordController.text,
                          );
                          } 
                        }, 
                        text: 'Login',
                      )
                      : Center(child: CircularProgressIndicator()),
                      
                      SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?'
                          ),
                          TextButton(
                            onPressed: (){
                              navigateTo(context, ShopRegisterScreen());
                            }, 
                            child: Text('register',
                            style: TextStyle(
                              color: defaultColor,
                            ),
                            ),
                            ),
                        ],
                      ),
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
