import 'package:first_pro/modules/news_app/web_view/web_view_screen.dart';
import 'package:first_pro/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

// Widget defaultButton({
//   required double width,
//   required Color background,
//   required Function function,
//   required String text,
// }) => Container(
//                     color: background,
//                     width: width,
//                     child: MaterialButton(
//                       onPressed: () {
//                         if (formkey.currentState!.validate()) {
//                           print(emialController.text);
//                           print(passwordController.text);
//                         }
//                       },
//                       child: Text(
//                         'LOGIN',
//                         style: TextStyle(fontSize: 20, color: Colors.white),
//                       ),
//                     ),
//                   );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  required FormFieldValidator<String> validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  GestureTapCallback? onTap,
  bool isClickable = true,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  validator: validate,
  onTap: onTap,
  enabled: isClickable,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    suffix: Icon(suffix),
    border: OutlineInputBorder(),
  ),
);

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.teal[100],
          child: Text(
            '${model['time']}',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
              Text('${model['date']}', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        SizedBox(width: 20.0),
        IconButton(
          onPressed: () {
            AppCubit.get(context).updateData(status: 'done', id: model['id']);
          },
          icon: Icon(Icons.check_box, color: Colors.green),
        ),
        IconButton(
          onPressed: () {
            AppCubit.get(
              context,
            ).updateData(status: 'archive', id: model['id']);
          },
          icon: Icon(Icons.archive, color: Colors.black45),
        ),
      ],
    ),
  ),
  onDismissed: (direction) {
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget buildArticleItem(article, context) => InkWell(
  onTap: () {
    navigateTo(context, WebViewScreen(article['url']));
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(width: double.infinity, height: 1, color: Colors.grey[300]),
);

void navigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => Widget),
  (route) {
    return false;
  },
);

Widget articleBuilder(list, context) =>
    list.length > 0
        ? ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder:
              (context, index) => buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: 10,
        )
        : Center(child: CircularProgressIndicator());
