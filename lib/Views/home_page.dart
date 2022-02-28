import 'package:contact/Controllers/apiprovider.dart';
import 'package:contact/Widgets/contact_card.dart';
import 'package:contact/Controllers/constants.dart';
import 'package:contact/Models/json_model.dart';
import 'package:contact/Views/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Contacts> initConList = ref.watch(contactsStateList);
    initConList?.sort((a, b) {
      return a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase());
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "Contacts",
            style: TextStyle(
              color: kVisaGold,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
      backgroundColor:
          initConList == null || initConList.isEmpty ? kWhite : kVisaBlue,
      floatingActionButton: Semantics(
        attributedLabel: AttributedString('Add new contact'),
        child: FloatingActionButton(
          backgroundColor:
              initConList == null || initConList.isEmpty ? kVisaGold : kWhite,
          onPressed: () {
            Navigator.pushNamed(context, "/new_contact");
          },
          child: Icon(
            Icons.add,
            color: kVisaBlue,
            size: 35,
          ),
        ),
      ),
      body: Center(
        child: initConList == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : initConList.isEmpty
                ? Image.network(
                    "https://c.tenor.com/lx2WSGRk8bcAAAAC/pulp-fiction-john-travolta.gif",
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: initConList.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                id: initConList[index].id,
                                email: initConList[index].email,
                                fName: initConList[index].firstName,
                                lName: initConList[index].lastName,
                                image: initConList[index].imagePath,
                                pNum: initConList[index].phoneNumber,
                              ),
                            ),
                          );
                        },
                        child: Semantics(
                          label:
                              "Contact Card for ${initConList[index].firstName} ${initConList[index].lastName}, phone number is ${initConList[index].phoneNumber} and email is ${initConList[index].email}",
                          child: ContactCard(
                            id: initConList[index].id,
                            firstName: initConList[index].firstName,
                            lastName: initConList[index].lastName,
                            email: initConList[index].email,
                            phoneNum: initConList[index].phoneNumber,
                            imagePath: initConList[index].imagePath,
                          ),
                        ),
                      );
                    }),
      ),
    );
  }
}
