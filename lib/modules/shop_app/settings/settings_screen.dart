import 'package:first_pro/layout/shop_app/cubit/cubit.dart';
import 'package:first_pro/layout/shop_app/cubit/states.dart';
import 'package:first_pro/shared/components/components.dart';
import 'package:first_pro/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ShopCubit.get(context).userModel != null
            ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if(state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty';
                          }
                          return null;
                        },
                        label: 'Full Name',
                        prefix: Icons.person,
                      ),
                      SizedBox(height: 20.0),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'email must not be empty';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefix: Icons.email,
                      ),
                      SizedBox(height: 20.0),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'phone must not be empty';
                          }
                          return null;
                        },
                        label: 'Phone Number',
                        prefix: Icons.phone,
                      ),
                      SizedBox(height: 20.0),
                      defaultButton(
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                            ShopCubit.get(context).updateUserData(
                            name: nameController.text, 
                            email: emailController.text, 
                            phone: phoneController.text
                            );
                          }
                        },
                        background: Colors.deepOrange,
                        width: double.infinity,
                        text: 'update',
                      ),
                      SizedBox(height: 20.0),
                      defaultButton(
                        onPressed: () {
                          signOut(context);
                        },
                        background: Colors.deepOrange,
                        width: double.infinity,
                        text: 'logout',
                      ),
                    ],
                  ),
                ),
              ),
            )
            : Center(child: CircularProgressIndicator());
      },
    );
  }
}
