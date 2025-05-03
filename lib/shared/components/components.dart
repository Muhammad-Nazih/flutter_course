import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_pro/layout/shop_app/cubit/cubit.dart';
import 'package:first_pro/modules/news_app/web_view/web_view_screen.dart';
import 'package:first_pro/shared/cubit/cubit.dart';
import 'package:first_pro/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Widget defaultTextButton({
//   required VoidCallback onPressed,
//   required String text,
//   required Color color,
// }) => TextButton(
//   onPressed: onPressed,
//   child: Text(text.toUpperCase(), selectionColor: color),
// );

Widget defaultTextButton({
  required VoidCallback onPressed,
  required String text,
  required Color color, // This will now control the text color
  Color? backgroundColor, // Optional: Add if you want a button background color
}) => TextButton(
  onPressed: onPressed,
  style: TextButton.styleFrom(
    foregroundColor: color, // Text color
    backgroundColor: backgroundColor, // Button background (optional)
  ),
  child: Text(text.toUpperCase()),
);

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Icon(IconBroken.Arrow___Left_2),
  ),
  titleSpacing: 5.0,
  title: Text(title!),
  actions: actions,
);

Widget defaultButton({
  double? width,
  Color background = Colors.orange,
  required VoidCallback onPressed,
  required String text,
  TextStyle? style,
}) => Container(
  color: background,
  width: width,
  height: 40.0,
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      text.toUpperCase(),
      style: style ?? TextStyle(fontSize: 16, color: Colors.white),
    ),
  ),
);

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
  bool isPassword = false,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  onChanged: onChange,
  validator: validate,
  onTap: onTap,
  enabled: isClickable,

  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon:
        suffix != null
            ? IconButton(
              icon: Icon(suffix),
              onPressed: suffixPressed,
              padding: EdgeInsets.zero,
            )
            : null,
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

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder:
      (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      ),
  fallback: (context) => Center(child: CircularProgressIndicator()),
);

void showToast({required String text, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildListProduct(model, context, {isOldPrice = true}) {
  if (model == null) return SizedBox(); // Prevent crash if model is null

  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image ?? ''),
                width: 120.0,
                height: 120.0,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120.0,
                    height: 120.0,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image),
                  );
                },
              ),
              if (model.discount != 0 && isOldPrice)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(fontSize: 8.0, color: Colors.white),
                  ),
                ),
            ],
          ),
          SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, height: 1.3),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.price?.toString() ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.deepOrange),
                    ),
                    SizedBox(width: 5.0),
                    if (model.discount != 0 && isOldPrice)
                      Text(
                        model.oldPrice?.toString() ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id!);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor:
                            (ShopCubit.get(context).favorites[model.id!] ==
                                    true)
                                ? Colors.deepOrange
                                : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
