import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newService =  Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body:Column(
          children: <Widget>[
            _ListaCategorias(),
            // (newService.categoryArticles.length==0)
            // ? Center(child: CircularProgressIndicator())
            // : Expanded(child: ListaNoticias(newService.getArticuloSeleccionada)) 
            Expanded(child: ListaNoticias(newService.getArticuloSeleccionada))

          ],
        ),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsService>(context).categories;
    
    return Container(
      width: double.infinity,
      height: 90.0,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {

        final cName = categories[index].name;
        return Padding(
          padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                CategoryButton(categories[index]),
                SizedBox( height: 15.0),
                Text("${cName[0].toUpperCase()}${cName.substring(1)} "  )
              ],
          ),
        );
        },
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final Category categoria;
  const CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newService =  Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: (){
        final newService =  Provider.of<NewsService>(context,listen: false);
        newService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white 
        ),
        child: Icon(
          categoria.icon,
          color:
          (newService.selectedCategory == this.categoria.name)
          ? Colors.blue
          :Colors.black54
        ),
      ),
    );
  }
}