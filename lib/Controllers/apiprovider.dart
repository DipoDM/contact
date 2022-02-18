import 'package:contact/Controllers/api.dart';
import 'package:contact/Models/json_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newConProvider = FutureProvider<List<Contacts>>((ref) async {
  final ContacLis _constss = ContacLis();
  return _constss.readJson();
});

final StateNotifierProvider<ContacLi, List<Contacts>> booksProvider =
    StateNotifierProvider((ref) {
  final oldConsts = ref.watch(newConProvider);
  return ContacLi(oldConsts.data?.value) == null
      ? []
      : ContacLi(oldConsts.data?.value);
});

class ContacLi extends StateNotifier<List<Contacts>> {
  ContacLi(List<Contacts> conList) : super(conList);

  void inert({@required Contacts num}) {
    state = [...state, num];
  }

  void remove({@required Contacts num}) {
    state = [
      for (final todo in state)
        if (todo.id != num.id) todo,
    ];
  }

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
