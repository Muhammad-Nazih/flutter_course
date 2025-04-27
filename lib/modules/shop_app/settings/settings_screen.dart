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

        if (model == null || model.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // هنا البيانات جاهزة، نقدر نحطها في الكنترولرز بأمان
        nameController.text = model.data!.name ?? '';
        emailController.text = model.data!.email ?? '';
        phoneController.text = model.data!.phone ?? '';

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 20.0),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate:
                        (value) =>
                            value!.isEmpty ? 'name must not be empty' : null,
                    label: 'Full Name',
                    prefix: Icons.person,
                  ),
                  const SizedBox(height: 20.0),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate:
                        (value) =>
                            value!.isEmpty ? 'email must not be empty' : null,
                    label: 'Email Address',
                    prefix: Icons.email,
                  ),
                  const SizedBox(height: 20.0),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate:
                        (value) =>
                            value!.isEmpty ? 'phone must not be empty' : null,
                    label: 'Phone Number',
                    prefix: Icons.phone,
                  ),
                  const SizedBox(height: 20.0),
                  defaultButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    background: Colors.deepOrange,
                    width: double.infinity,
                    text: 'update',
                  ),
                  const SizedBox(height: 20.0),
                  defaultButton(
                    onPressed: () => signOut(context),
                    background: Colors.deepOrange,
                    width: double.infinity,
                    text: 'logout',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
