import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobilellc_task/models/book.dart';
import 'package:mobilellc_task/utils/constantdata.dart';

Future<MusicModel> loadBooks(String apiQueryName, String apiQueryData) async {
  MusicModel bookModel = MusicModel();
  String jsonAddress = await fetchBooks(apiQueryName, apiQueryData);
  if (jsonAddress != null) {
    var data = json.decode(jsonAddress);
    bookModel = MusicModel.fromJson(data);
    return bookModel;
  }
  return null;
}

Future<String> fetchBooks(String apiQueryName, String apiQueryData) async {
  String url = baseAPI;

  url = url + "&" + apiQueryName + "=" + apiQueryData;
  print("APIURL url>>:" + url);
  try {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    // print(response.body);
    return (response.body);
  } catch (e) {
    return null;
  }
}

Future<MusicModel> loadNextBooks(String nextApi) async {
  MusicModel bookModel = MusicModel();
  String url = nextApi;
  print("APIURL url>>:" + url);
  try {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    // print(response.body);
    if (response.body != null) {
      var data = json.decode(response.body);
      bookModel = MusicModel.fromJson(data);
      return bookModel;
    }
    // return (response.body);
  } catch (e) {
    return null;
  }
  return null;
}

Future<MusicModel> searchBook(String value) {
  print(value);
  List<String> searchQueryList = value.split(" ");
  String searchQuery = "";
  if (searchQueryList.length > 1) {
    int i=0;
    for (var item in searchQueryList) {
      if(i==0)
        searchQuery =item;
      else
        searchQuery =searchQuery+ "+" + item;
      i++;
    }
  } else {
    searchQuery = value;
  }
  
  return loadNextBooks("$baseAPI$searchQuery");
}