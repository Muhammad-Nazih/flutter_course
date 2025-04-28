import 'package:first_pro/layout/social_app/cubit/cubit.dart';
import 'package:first_pro/layout/social_app/cubit/states.dart';
import 'package:first_pro/shared/components/components.dart';
import 'package:first_pro/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({super.key});

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                onPressed: () {
                  var now = DateTime.now();
                  if(SocialCubit.get(context).postImage == null){
                    SocialCubit.get(context).createPost(
                      dateTime: now.toString(), 
                      text: textController.text,
                    );
                  } else{
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: now.toString(), 
                      text: textController.text,
                    );
                  }
                },
                text: 'Post',
                color: Colors.orange,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/front-view-young-male-with-excited-expression-christmas-emotion-christmas_140725-123749.jpg?t=st=1745541403~exp=1745545003~hmac=e98d8f282718d78726b2d138d71b79d4c762b2401859088105aa309b362734f9&w=1380',
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Expanded(child: Text('Muhammad Nazih')),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is in your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage != null)
                  // Stack(
                  //           alignment: AlignmentDirectional.topEnd,
                  //           children: [
                  //             Container(
                  //               height: 140.0,
                  //               width: double.infinity,
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(4),
                  //                 image: DecorationImage(
                  //                   // image: FileImage(SocialCubit.get(context).postImage),
                  //                   fit: BoxFit.cover,
                  //                 ),
                  //               ),
                  //             ),
                  //             IconButton(
                  //               onPressed: () {
                  //                 SocialCubit.get(context).getCoverImage();
                  //               },
                  //               icon: CircleAvatar(
                  //                 radius: 20.0,
                  //                 child: Icon(
                  //                   Icons.close,
                  //                   size: 18.0,
                  //                   color: Colors.orange,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                          SocialCubit.get(context).getPostImage();
                        }, 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5.0),
                            Text('add photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: (){}, 
                          child: Text('# tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
