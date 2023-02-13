
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/modules/web_view/web_view_screen.dart';
import '../../layouts/shop_app/cubit/cubit.dart';
import '../styles/colors.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(url: article['url']));
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
                    fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget myDivider() => const Padding(
    padding: EdgeInsets.all(8.0),
    child: Divider(
      thickness: 1.0,
      color: Colors.grey,
      endIndent: 20.0,
      indent: 20.0,
    ));

void navigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.deepOrange,
  bool isUppercase = true,
  double radius = 3.0,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        minWidth: double.infinity,
        height: 40.0,
        color: Colors.deepOrange,
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color? chooseToastColor(ToastStates state) {
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


