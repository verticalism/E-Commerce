import 'dart:convert';
import 'package:vetore/model/fakestoreapimodel.dart';
import 'package:http/http.dart' as http;

Future<List<Item>> fetchProducts() async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => Item.fromJson(item)).toList();
  } else {
    throw Exception('Failed / Wait to load products');
  }
}
