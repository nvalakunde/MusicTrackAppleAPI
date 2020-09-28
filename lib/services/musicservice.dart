import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobilellc_task/models/music.dart';
import 'package:mobilellc_task/utils/constantdata.dart';

Future<MusicModel> searchMusicss(String value) async {
  print(value);
  final List<String> searchQueryList = value.split(' ');
  String searchQuery = '';
  if (searchQueryList.length > 1) {
    int i = 0;
    for (final String item in searchQueryList) {
      if (i == 0)
        searchQuery = item;
      else
        searchQuery = searchQuery + '+' + item;
      i++;
    }
  } else {
    searchQuery = value;
  }

  // return loadNextBooks('$baseAPI$searchQuery');
  MusicModel bookModel = MusicModel();
  final String url = '$baseAPI$searchQuery';
  print('APIURL url loadNextBooks>>:' + url);
  try {
    final http.Response response = await http
        // ignore: always_specify_types
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    print(response.body);
    if (response.body != null) {
      final dynamic data = json.decode(response.body);
      bookModel = MusicModel.fromJson(data);
      return bookModel;
    }
    // return (response.body);
  } catch (e) {
    return null;
  }
  return null;
}

Future<MusicModel> searchMusics(String nextApi) async {
  MusicModel bookModel = MusicModel();
  final String url = '$baseAPI$nextApi';
  print('APIURL url>>:' + url);
  try {
    // ignore: always_specify_types
    final response = await http
        // ignore: always_specify_types
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    // ignore: always_specify_types
    var data = json.decode(response.body);
    if (data != null) {
      bookModel = MusicModel.fromJson(data);
      print('bookModel');
      print(bookModel);
      return bookModel;
    }
    // return (response.body);
  } catch (e) {
    print('CATCH bookModel');
    print(e);
    return null;
  }
  print('RETUR bookModel');
  return null;
}
