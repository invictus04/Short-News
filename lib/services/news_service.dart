import 'package:inshorts/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsService {


  Future<News?> getAllNews(String categoryName) async{
    var client = http.Client();
    var uri = Uri.parse("http://10.0.2.2:5000/news?category=${categoryName}");


    var response = await client.get(uri);

    if(response.statusCode == 200){
      var json = response.body;
      return newsFromJson(json);
    }




  }


}
