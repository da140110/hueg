import 'package:flutter/material.dart';
import '../../../scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
class NewsHelper {

  static var articleCount = 4;

  static var categoryTitles = ["SPACE", "FROM YOUR NETWORK", "BASED ON YOUR READING HISTORY", "DATA SCIENCE"];
  static var titles = ["Sorry, Methane and 'Organics' On Mars Are Not Evidence For Life", "A crash course on Serverless APIs with Express and MongoDB", "What happened Gmail?", "A year as a Data Scientist right after college: An honest review"];
  static var authorNames = ["Ethan Siegal", "Adnan Rahic", "Avi Ashkenazi", "Abhishek Parkbhakar"];
  static var date = ["15 Jun", "15 hours ago", "27 Apr", "14 Jun"];
  static var readTimes = ["7 min read", "14 min read", "8 min read", "8 min read"];
  static var imageAssetName = ["mars.jpeg","cars.jpeg","gmail.jpeg","umbrella.jpeg"];

  static getArticle(int position) {
    return NewsArticle(categoryTitles[position], titles[position], authorNames[position],date[position],readTimes[position], imageAssetName[position]);
  }

}
class NewsArticle {

  String categoryTitle;
  String title;
  String author;
  String date;
  String readTime;
  String imageAssetName;

  NewsArticle(this.categoryTitle, this.title, this.author, this.date,
      this.readTime, this.imageAssetName);

}
class TrangChuPheDuyetPhanAnh extends StatefulWidget {
  final MainModel model;
  TrangChuPheDuyetPhanAnh({this.model});
  @override
  _TrangChuPheDuyetPhanAnhState createState() => new _TrangChuPheDuyetPhanAnhState();
}

class _TrangChuPheDuyetPhanAnhState extends State<TrangChuPheDuyetPhanAnh> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {

      Navigator.pop(context, false);
      return Future.value(false);
    }, child: ScopedModelDescendant<MainModel>(
    builder: (BuildContext context, Widget child, MainModel model) {
    //final Product product = model.products[productIndex];
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Xử lý phản ánh",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Icon(
              Icons.notifications_none,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(Icons.search, color: Colors.grey),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, position) {
          NewsArticle article = NewsHelper.getArticle(position);

          return Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      article.categoryTitle,
                      style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              article.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22.0),
                            ),
                            flex: 3,
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                                height: 80.0,
                                width: 80.0,
                                child: Image.asset(
                                  "assets/" + article.imageAssetName,
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              article.author,
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Text(
                              article.date + " . " + article.readTime,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Icon(Icons.bookmark_border),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: NewsHelper.articleCount,
      ),
    );
    },
    ));
  }
}
