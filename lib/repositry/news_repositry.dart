
  import 'dart:async';
import 'dart:core';

import '../data/news_services.dart';
import '../news_model/news_categorychannel.dart';
import '../news_model/news_categorymodel.dart';

class NewsRepository {
  final  _networkservices = NetworkServices();

  Future<NewsArticles> fetchNewsbyCategory(String category) async {
    try {
      dynamic response= await _networkservices.getGetResponseApi('https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=ae04d9d089234c82b671754fa7fe3385');

            return NewsArticles.fromJson(response);


    } catch (e) {
      throw Exception("Time out");
    }
  }
  Future<NewsChannel>fetchnewsByChannel(String channel) async {
    try{

      dynamic response=await _networkservices.getGetResponseApi
        ('https://newsapi.org/v2/top-headlines?country=in&category=$channel&apiKey=ae04d9d089234c82b671754fa7fe3385');
      return NewsChannel.fromJson(response);
    }


    catch(e){
      throw Exception("Time out");
    }

  }





}







