import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mento_mind_assignment/modal/test_modal.dart';

class TestRepository {
  Future<List<Topics>> getTests() async {
    var response = await http.get(
      Uri.parse(
          'https://utkwwq6r95.execute-api.us-east-1.amazonaws.com/assignment/topics'),
      headers: {
        'userid': '25794905-2dd4-40bd-97b9-9d5d69294b86',
        'token': 'd61036c6-5ffd-4964-b7ff-8d5ba8ca0262'
      },
    );
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);

      return result.map((e) => Topics.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }
}
