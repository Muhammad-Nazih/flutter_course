import 'package:first_pro/layout/social_app/cubit/cubit.dart';
import 'package:first_pro/layout/social_app/cubit/states.dart';
import 'package:first_pro/models/social_app/message_model.dart';
import 'package:first_pro/models/social_app/social_user_model.dart';
import 'package:first_pro/models/user/user_model.dart';
import 'package:first_pro/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? userModel;
  ChatDetailsScreen({this.userModel});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(receiverId: userModel!.uId!);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(userModel!.image!),
                    ),
                    SizedBox(width: 15.0),
                    Text(userModel!.name!),
                  ],
                ),
              ),
              body:
                  SocialCubit.get(context).messages.length > 0
                      ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var message =
                                      SocialCubit.get(context).messages[index];
                                  if (SocialCubit.get(context).userModel!.uId ==
                                      message.senderID)
                                    {
                                      return buildMyMessage(message);
                                    }
                              
                                  return buildMessage(message);
                                },
                                separatorBuilder:
                                    (context, index) => SizedBox(height: 15.0),
                                itemCount:
                                    SocialCubit.get(context).messages.length,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'type your message here ...',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    color: Colors.blue,
                                    child: MaterialButton(
                                      onPressed: () {
                                        SocialCubit.get(context).sendMessage(
                                          receiverId: userModel!.uId,
                                          dateTime: DateTime.now().toString(),
                                          text: messageController.text,
                                        );
                                      },
                                      minWidth: 1.0,
                                      child: Icon(
                                        IconBroken.Send,
                                        size: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      : Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }

  Widget buildMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    child: Text(model.text!),
    ),
  );

  Widget buildMyMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.2),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Text(model.text!),
    ),
  );
}
