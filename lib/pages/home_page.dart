import 'package:exam_setstate/models/articles_list_news_model.dart';
import 'package:exam_setstate/services/http_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  int currentPage = 1;
  List<Article> list = [];

  loadArticleNews() async {
    var response =
        await Network.GET(Network.API_NEWS_INFOS, Network.paramsArticle());
    List<Article> articles = Network.parseArticles(response!);
    print(articles.length);
    setState(() {
      list = articles;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadArticleNews();
    print(list.length);
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent <= scrollController.offset){
        loadArticleNews();
      }
      });
        }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text("N E W S",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        ),
        body: ListView.builder(
            controller: scrollController,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return itemOfArticleListNews(list[index], index);
            }));
  }

  Widget itemOfArticleListNews(Article list, int index) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage(
                      image: NetworkImage(list.urlToImage!),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(),
              Card(
                color: Colors.black54,
                margin: EdgeInsets.all(20),
                child: Text(
                  list.source!.name!,
                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),




            ],
          ),
        ),
        SizedBox(),
        Card(
          color: Colors.black54,

          child: Text(
            list.title!,
            style: TextStyle(fontSize: 16,color: Colors.white,),
          ),
        ),

        SizedBox(),
        Card(
          color:Colors.black54 ,
          child: Text(
            list.description!,
            style: TextStyle(fontSize: 16,color:Colors.white),
          ),
        ),
        SizedBox(),
        Card(
          color: Colors.black54,
          child: Text(
            list.content!,
            style: TextStyle(fontSize: 16,color: Colors.white),
          ),
        ),
        SizedBox(),
        Card(
        color: Colors.black54,
          child: Text(

            list.url!,
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
