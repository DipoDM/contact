import 'package:contact/Controllers/apiprovider.dart';
import 'package:contact/Controllers/constants.dart';
import 'package:contact/Models/json_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewContactPage extends ConsumerWidget {
  NewContactPage({Key key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ContacLi bookStateNotifier = ref.watch(booksProvider.notifier);
    final List<Contacts> bookList = ref.watch(booksProvider);

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: kVisaGold,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 18,
                        color: kVisaBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    "New Contact",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final isValid = _formKey.currentState.validate();
                      if (!isValid) {
                        return null;
                      } else {
                        bookStateNotifier.inert(
                          num: Contacts(
                            id: (bookList.length + 1).toString(),
                            firstName: firstNameController.text.trim(),
                            lastName: lastNameController.text.trim(),
                            phoneNumber: phoneNumController.text.trim(),
                            email: emailController.text.trim(),
                            imagePath: "assets/images/user.jpeg",
                          ),
                        );
                        _formKey.currentState.save();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 1),
                                backgroundColor: Colors.red,
                                content: Text(
                                  'Saved',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: kBlack,
                                  ),
                                ),
                              ),
                            )
                            .closed
                            .then(
                              (value) => Navigator.pop(context),
                            );
                      }
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 18,
                        color: kVisaBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      // height: size.height * 0.3,
                      width: displaySize(context).width,
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/profile.jpg",
                            width: displaySize(context).width,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 10,
                            child: IconButton(
                              onPressed: () {},
                              iconSize: 30,
                              icon: const Icon(
                                Icons.camera_alt,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          // semanticCounterText: "Testing",
                          border: OutlineInputBorder(),
                          hintText: 'e.g John',
                          labelText: 'First name',
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.trim().length == 0) {
                            return 'Please enter your first name.';
                          } else {
                            firstNameController.text = value.toString().trim();
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'e.g Snow',
                          labelText: 'Last name',
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.trim().length == 0) {
                            return 'Please enter your last name.';
                          } else {
                            lastNameController.text = value.toString().trim();
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'e.g 872 555 2390',
                          labelText: 'Phone number',
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.trim().length == 0) {
                            return 'Please enter your phone number.';
                          } else if (value.length != 10) {
                            return "Please check phone number";
                          } else {
                            phoneNumController.text = value.toString().trim();
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.0,
                            ),
                          ),
                          hintText: 'e.g you@example.com',
                          labelText: 'E-mail Address',
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.trim().length == 0) {
                            return 'Please enter your email.';
                          } else if (!value.contains("@") ||
                              !value.contains(".com")) {
                            return 'Please check email';
                          } else {
                            emailController.text = value.toString().trim();
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
