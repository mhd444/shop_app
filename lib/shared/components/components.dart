
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(article,context) => InkWell(
  onTap: (){
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
            image: DecorationImage(image: NetworkImage('${article['urlToImage']}'),
            fit: BoxFit.fill
            ),
          ),
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('${article['title']}',
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('${article['publishedAt']}',style: TextStyle(
                    color: Colors.grey
                ),)
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

void navigateTo(context,Widget) => Navigator.push(
    context, MaterialPageRoute(builder: (context) => Widget));
