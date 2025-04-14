import 'package:first_pro/modules/shop_app/login/shop_login_screen.dart';
import 'package:first_pro/shared/components/components.dart';
import 'package:first_pro/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salla',
        ),
      ),
      body: TextButton(
        onPressed: (){
          CacheHelper.removeData(key: 'token').then((value){
            if(value) {
              navigateAndFinish(context, ShopLoginScreen());
            }
          });
        }, 
        child: Text(
          'SIGN OUT',
        )),
    );
  }
}