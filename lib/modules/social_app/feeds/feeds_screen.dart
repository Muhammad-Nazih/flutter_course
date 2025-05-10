import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_pro/layout/social_app/cubit/cubit.dart';
import 'package:first_pro/layout/social_app/cubit/states.dart';
import 'package:first_pro/models/social_app/post_model.dart';
import 'package:first_pro/models/user/user_model.dart';
import 'package:first_pro/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SocialCubit.get(context).posts.isNotEmpty
            ? SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                            'https://img.freepik.com/free-photo/portrait-smiling-young-man-pointing-something-against-colored-backdrop_23-2148119641.jpg?t=st=1745539929~exp=1745543529~hmac=1f5e8d38cd9acf56dfc7b8eeeca33562d025640961d1f7c9e7fb29b8962ed698&w=1480',
                          ),
                          fit: BoxFit.cover,
                          height: 200.0,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Communicate with friends',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder:
                        (context, index) => buildPostItem(
                          SocialCubit.get(context).posts[index],
                          context,
                          index,
                        ),
                    separatorBuilder: (context, index) => SizedBox(height: 8.0),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${model.name}'),
                        SizedBox(width: 5.0),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 16.0,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15.0),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_horiz, size: 16.0),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text('${model.text}'),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#sofware',
          //                 style: Theme.of(
          //                   context,
          //                 ).textTheme.bodySmall!.copyWith(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6.0),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#flutter',
          //                 style: Theme.of(
          //                   context,
          //                 ).textTheme.bodySmall!.copyWith(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if (model.postImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 15.0),
              child: Container(
                height: 140.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    image: NetworkImage('${model.postImage}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(IconBroken.Heart, size: 16.0, color: Colors.red),
                          SizedBox(width: 5.0),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Chat,
                            size: 16.0,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            '0 comment',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}',
                        ),
                      ),
                      SizedBox(width: 15.0),
                      Text(
                        'write a comment ...',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall!.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  SocialCubit.get(
                    context,
                  ).likePost(SocialCubit.get(context).postsId[index]);
                },
                child: Row(
                  children: [
                    Icon(IconBroken.Heart, size: 16.0, color: Colors.red),
                    SizedBox(width: 5.0),
                    Text(
                      'Like',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
