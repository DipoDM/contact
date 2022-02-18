import 'dart:convert';
import 'package:contact/Models/json_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ContacLis {
  Future<List<Contacts>> readJson() async {
    List<dynamic> pageList = [];
    try {
      final String response =
          await rootBundle.loadString('assets/local_data/local_data.json');
      List<dynamic> data = await json.decode(response);
      pageList = data.map((d) => Contacts.fromJson(d)).toList();
      pageList.sort((a, b) {
        return a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase());
      });
    } catch (e) {
      if (kDebugMode) {
        print(
          "Error: ${e.toString()}",
        );
      }
      return e;
    }
    return pageList ?? [];
  }
}
