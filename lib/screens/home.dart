import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:my_news_app_project/data/status.dart';
import 'package:my_news_app_project/news_model/news_categorymodel.dart';
import 'package:my_news_app_project/screens/newsdetails_screen.dart';

import '../controller/news_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
  final newsController = Get.put(NewsController());
  String categoryname = 'technology';

  List<String> categorylist = [
    'technology',
    'science',
    'health',
    'entertainment',
    'general',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsController.fetchNewsbyCategory(categoryname);
  }

  @override
  Widget build(BuildContext context) {
    final height = Get.height * 1;
    final width = Get.width * 1;

    return Scaffold(


          appBar: AppBar(
         centerTitle: true,
          title:const Text("News"),
          ),
         
        body: Column(children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categorylist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      categoryname = categorylist[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        decoration: BoxDecoration(
                            color: categoryname == categorylist[index]
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Center(
                            child: Text(categorylist[index].toString()),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Obx((){
            switch (newsController.rxResquestStatus.value) {
              case Status.LOADING:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case Status.COMPLETED:
                return ListView.builder(
                      itemCount: newsController.articles.value.articles!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                           onTap:(){

            String newsImage =
            newsController
                .articles.value.articles![index].urlToImage!;
            String newsTitle =
            newsController
                .articles.value.articles![index].title!;
            String newsDate =
            newsController
                .articles.value.articles![index].publishedAt!;
            String newsAuthor =
            newsController
                .articles.value.articles![index].author!;
            String newsDesc =
            newsController
                .articles.value.articles![index].description!;
            String newsContent =
            newsController
                .articles.value.articles![index].content!;
            String newsSource =
            newsController
                .articles.value.articles![index].source!.name!;
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailScreen(
            newsImage,
            newsTitle,
            newsAuthor,
            newsDesc,
            newsContent,
            newsSource
            )));












            },
                          child: Row(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: newsController
                                    .articles.value.articles![index].urlToImage
                                    .toString(),
                                fit: BoxFit.cover,
                                height: height * .18,
                                width: width * .3,
                                placeholder: (context, url) => Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Expanded(
                                child: Container(
                                    height: height * .18,
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(children: [
                                      Text(
                                        newsController
                                            .articles.value.articles![index].title
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black),
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            newsController.articles.value
                                                .articles![index].author
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ])))
                          ]),
                        );
                      });

              case Status.ERROR:
                return const Text("Error");
              default:
        // Show a loading indicator or error message if the request is not completed
        return Center(
          child: Text("Error"),
        );



            }
          }),
        ]));
  }
}
