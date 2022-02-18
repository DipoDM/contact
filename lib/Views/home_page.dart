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
    final List<Contacts> bookList = ref.watch(booksProvider);
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
          bookList == null || bookList.isEmpty ? kWhite : kVisaBlue,
      floatingActionButton: Semantics(
        attributedLabel: AttributedString('Add new contact'),
        child: FloatingActionButton(
          backgroundColor:
              bookList == null || bookList.isEmpty ? kVisaGold : kWhite,
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
        child: bookList == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : bookList.isEmpty
                ? Image.network(
                    "https://c.tenor.com/lx2WSGRk8bcAAAAC/pulp-fiction-john-travolta.gif",
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: bookList.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                id: bookList[index].id,
                                email: bookList[index].email,
                                fName: bookList[index].firstName,
                                lName: bookList[index].lastName,
                                image: bookList[index].imagePath,
                                pNum: bookList[index].phoneNumber,
                              ),
                            ),
                          );
                        },
                        child: Semantics(
                          label:
                              "Contact Card for ${bookList[index].firstName} ${bookList[index].lastName}, phone number is ${bookList[index].phoneNumber} and email is ${bookList[index].email}",
                          child: ContactCard(
                            id: bookList[index].id,
                            firstName: bookList[index].firstName,
                            lastName: bookList[index].lastName,
                            email: bookList[index].email,
                            phoneNum: bookList[index].phoneNumber,
                            imagePath: bookList[index].imagePath,
                          ),
                        ),
                      );
                    }),
      ),
    );
  }
}
