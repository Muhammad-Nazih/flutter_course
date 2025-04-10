import 'package:first_pro/shared/components/components.dart';
import 'package:flutter/material.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('LOGIN', style: Theme.of(context).textTheme.headlineSmall),
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
              suffix: Icons.visibility_outlined,
              suffixPressed: () {},
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'password is too short';
                }
              },
              label: 'Password',
              prefix: Icons.lock_outline,
            ),
          ],
        ),
      ),
    );
  }
}
