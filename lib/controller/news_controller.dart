import 'package:get/get.dart';

import '../data/status.dart';
import '../news_model/news_categorymodel.dart';
import '../repositry/news_repositry.dart';



class NewsController extends GetxController {
  final NewsRepository _newsRepository = NewsRepository();
        final rxResquestStatus=Status.LOADING.obs;
        final articles=NewsArticles().obs;

        void setRxReqeustStatus(Status _value)=>rxResquestStatus.value=_value;
      void  setUserList(NewsArticles _value) =>articles.value= _value ;





      void fetchNewsbyCategory(String category){
          _newsRepository.fetchNewsbyCategory(category).then((value){
            setRxReqeustStatus(Status.COMPLETED);
            setUserList(value);

          }). onError((error, stackTrace){
            setRxReqeustStatus(Status.ERROR);
          });


        }





}