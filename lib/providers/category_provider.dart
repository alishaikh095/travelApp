import 'package:flutter/material.dart';
import '../models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Categories with ChangeNotifier {
  List<Category> _catList = [];
  List<String> _catImgs = [];
  List<Category> _listcats = [];

  List<Category> get catItems {
    return [..._catList];
  }

  List<Category> get listcat {
    return [..._listcats];
  }

  List<String> get catImgItems {
    return [..._catImgs];
  }

  Future<void> fetchCategory() async {
    const url =
        'https://www.emraancheema.com/app/wp-json/get_app_banner_cat/v1';
    try {
      final exclData = await http.get(Uri.parse(url));
      final homeCatgry = json.decode(exclData.body) as Map<String, dynamic>;
      final List<Category> catArray = [];
      final List<String> catImgs = [];
      homeCatgry.forEach((key, value) {
        if (key == 'banner_cat') {
          value.forEach((catItem) {
            catArray
                .add(Category(id: catItem['term_id'], title: catItem['name']));
          });
        }
        if (key == 'banner_cat_img') {
          value.forEach((img) {
            catImgs.add(img);
          });
        }
      });
      _catList = catArray;
      _catImgs = catImgs;
      notifyListeners();
    } catch (error) {
      // print(error);
    }
  }

  Future<void> fetchListingCategory() async {
    const url =
        'https://www.emraancheema.com/app/wp-json/wp/v2/listing-category';
    try {
      final exclData = await http.get(Uri.parse(url));
      final lisCatgry = json.decode(exclData.body) as List<dynamic>;
      final List<Category> catArray = [];

      lisCatgry.forEach((catItem) {
        catArray.add(Category(id: catItem['id'], title: catItem['name']));
      });
      _listcats = catArray;
      notifyListeners();
    } catch (error) {
      // print(error);
    }
  }

  Category findById(int id) {
    return _catList.firstWhere((catg) => catg.id == id);
  }
}
