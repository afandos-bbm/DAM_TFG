import 'dart:convert';
import 'package:client_project/domain/entities/category.dart';
import 'package:client_project/main.dart';
import 'package:client_project/ui/widgets/category/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class CategoryList extends StatefulWidget {
  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: getMarcas(),
      ),
    );
  }

  List<CategoryItem> getMarcas() {
    List<Category> marcas = [];
    String jsonString = MyApp.marcasJson;
    List<dynamic> jsonResponse = json.decode(jsonString);
    jsonResponse.forEach((element) => marcas
        .add(Category(element['nombre'], element['logo'], element['modelos'])));
    List<CategoryItem> categories = [];
    marcas.forEach((element) => categories.add(
        CategoryItem(image: Image.asset(element.image, bundle: rootBundle))));
    return categories;
  }
}
