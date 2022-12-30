//https://newsapi.org/          base url
// v2/top-headlines?            method
// country=eg&category=business&apiKey=69cca983d4cb4cb1b55ec89e6fd19d06        query
//--------------------------
//https://newsapi.org/
//v2/everything?
//q=tesla&apiKey=69cca983d4cb4cb1b55ec89e6fd19d06

import 'package:flutter/material.dart';
import 'package:news_app/webview.dart';

Widget buildNewsScreens(article, context,) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewScreen(article['url'])
          )
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.cover
                )
            ),
          ),
          SizedBox(width: 15,),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.subtitle1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    color: Colors.grey.shade400
                  ),)
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
Widget myDivider () {
  return Container(
    width: double.infinity,
    height: 2,
    color: Colors.grey.shade200,
  );
}


