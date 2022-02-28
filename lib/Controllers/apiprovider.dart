import 'package:contact/Controllers/api.dart';
import 'package:contact/Models/json_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This section initially reads the data from the API call and populates it in the future provider - One time read at start of the app
final newConProvider = FutureProvider<List<Contacts>>((ref) async {
  final ContacLis _constss = ContacLis();
  return _constss.readJson();
});

//This is responsible for making changes to the List of contacts with each CRUD function
final StateNotifierProvider<ContacLi, List<Contacts>> contactsStateList =
    StateNotifierProvider((ref) {
  final oldConsts = ref.watch(newConProvider);
  return ContacLi(oldConsts.data?.value) == null
      ? []
      : ContacLi(oldConsts.data?.value);
});

// This contains the CRUD functions that can be performed on the List
class ContacLi extends StateNotifier<List<Contacts>> {
  ContacLi(List<Contacts> conList) : super(conList);

// inserts into the list
  void inert({@required Contacts num}) {
    state = [...state, num];
  }

// deletes any element that matches the argument
  void remove({@required Contacts num}) {
    state = [
      for (final todo in state)
        if (todo.id != num.id) todo,
    ];
  }

//updates any element that matches the argument
  void update({@required Contacts oldNum, @required Contacts newNum}) {
    List nState;
    nState = state;
    nState = [
      for (Contacts i in nState)
        if (i.id == oldNum.id)
          {
            remove(num: oldNum),
            inert(num: newNum),
            nState,
          }
    ];
  }
}
