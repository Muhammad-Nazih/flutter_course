import 'package:first_pro/layout/social_app/cubit/cubit.dart';
import 'package:first_pro/layout/social_app/cubit/states.dart';
import 'package:first_pro/models/social_app/social_user_model.dart';
import 'package:first_pro/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:first_pro/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SocialCubit.get(context).users.length > 0
            ? ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder:
                  (context, index) =>
                      buildChatItem(SocialCubit.get(context).users[index], context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: SocialCubit.get(context).users.length,
            )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, contetx) => InkWell(
    onTap: () {
      navigateTo(contetx, ChatDetailsScreen(
        userModel: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(width: 15.0),
          Text('${model.name}'),
        ],
      ),
    ),
  );
}
