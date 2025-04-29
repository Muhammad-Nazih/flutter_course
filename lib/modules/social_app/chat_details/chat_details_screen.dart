import 'package:first_pro/models/social_app/social_user_model.dart';
import 'package:first_pro/models/user/user_model.dart';
import 'package:flutter/material.dart';

class ChatDetailsScreen extends StatelessWidget {

  SocialUserModel? userModel;
  ChatDetailsScreen({this.userModel});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(userModel!.image!),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              userModel!.name!,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                  )
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Text(
                  'Hello World',
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10.0),
                  )
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Text(
                  'Hello World',
                ),
              ),
            ),
            Row(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'type your message',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}