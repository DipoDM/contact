import 'dart:convert';
import 'package:contact/Models/json_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

//This where the hard-coded data is called and loaded into a list

class ContacLis {
  Future<List<Contacts>> readJson() async {
    List<dynamic> pageList = [];
    try {
      final String response =
          await rootBundle.loadString('assets/local_data/local_data.json');
      List<dynamic> data = await json.decode(response);
      pageList = data.map((d) => Contacts.fromJson(d)).toList();
      // this sorts the data in alphabetical order
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
