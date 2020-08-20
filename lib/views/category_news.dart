import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';

import 'article_view.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  _CategoryNewsState();

  @override
  void initState() {
    getCatogoryNews();
    // TODO: implement initState
    super.initState();
  }

  void getCatogoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "News",
              style: TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.w600),
            ),
            Text(
              "Flash",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.share,
                )),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Container(
                  padding: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                      itemCount: articles.length,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return BlogTile(
                          imageUrl: articles[index].urlToImage ?? "",
                          title: articles[index].title ?? "",
                          desc: articles[index].description ?? "",
                          url: articles[index].url ?? "",
                        );
                      }),
                ),
              ),
            ),
    );
  }
}

class CategoryTitle extends StatelessWidget {
  final String categoryName;

  const CategoryTitle({ this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        categoryName,
        style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),

    );
  }
}


class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  BlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.url});

  @override
  Widget build(BuildContext context) {

    return Center(

      child: Padding(
        padding: const EdgeInsets.all(4.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
        ),
        elevation: 10.0,
        shadowColor: Colors.redAccent,
        margin: EdgeInsets.fromLTRB(4, 2, 4, 2),


        child: InkWell(

          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleView(
                      blogUrl: url,
                    ))

            );
          },

            child: Container(
              margin: EdgeInsets.all(4),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(imageUrl)),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    desc,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}
