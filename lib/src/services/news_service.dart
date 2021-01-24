import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http; 

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY = 'e4dca889fab445d6b8aaee880ca01d48';

class NewsService with ChangeNotifier{
  
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category( FontAwesomeIcons.building, 'business'),
    Category( FontAwesomeIcons.tv, 'entertainment'),
    Category( FontAwesomeIcons.addressCard, 'general'),
    Category( FontAwesomeIcons.headSideVirus, 'health'),
    Category( FontAwesomeIcons.vial, 'science'),
    Category( FontAwesomeIcons.volleyballBall, 'sports'),
    Category( FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String,List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();
    
    categories.forEach((element) {
      this.categoryArticles[element.name] = new List();
    });
  
  }

  get selectedCategory=> this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  getTopHeadlines() async {
    
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=co';
    final resp = await http.get(url);
    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll( newsResponse.articles );
    notifyListeners();

  }

  getArticlesByCategory(String categoria) async {

    if( this.categoryArticles[categoria].length > 0 ){
      return this.categoryArticles[categoria];
    }

    final url  = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=co&category=$categoria';
    final resp = await http.get(url);
    final newsResponse =  newsResponseFromJson(resp.body);
    this.categoryArticles[categoria].addAll(newsResponse.articles);
    notifyListeners();
  }

  List<Article>get getArticuloSeleccionada => this.categoryArticles[this._selectedCategory];


}