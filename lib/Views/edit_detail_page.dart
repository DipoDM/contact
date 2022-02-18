import 'package:contact/Controllers/apiprovider.dart';
import 'package:contact/Controllers/constants.dart';
import 'package:contact/Models/json_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  String id;
  String fName;
  String lName;
  String pNum;
  String image;
  String email;

  EditPage({
    Key key,
    this.id,
    this.fName,
    this.lName,
    this.pNum,
    this.image,
    this.email,
  }) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kVisaBlue,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: displaySize(context).width,
                child: Wrap(
                  alignment: WrapAlignment
                      .spaceBetween, //AxisAlignment: MainAxisAlignment.spaceBetween,
                  // runAlignment: WrapAlignment.spaceBetween,
                  // alignment: WrapAlignment,
                  // runAlignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 15,
                          color: kVisaGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      "New Contact",
                      style: TextStyle(
                        color: kVisaGold,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final ContacLi bookStateNotifier =
                            ref.watch(booksProvider.notifier);
                        return TextButton(
                          onPressed: () {
                            final isValid = _formKey.currentState.validate();
                            if (!isValid) {
                              return null;
                            } else {
                              bookStateNotifier.update(
                                oldNum: Contacts(id: widget.id),
                                newNum: Contacts(
                                  id: widget.id,
                                  firstName: firstNameController.text.trim(),
                                  lastName: lastNameController.text.trim(),
                                  phoneNumber: phoneNumController.text.trim(),
                                  imagePath: widget.image,
                                  email: emailController.text.trim(),
                                ),
                              );
                              setState(() {
                                widget.id = widget.id;
                                widget.fName = firstNameController.text.trim();
                                widget.lName = lastNameController.text.trim();
                                widget.email = emailController.text.trim();
                                widget.image = widget.image;
                                widget.pNum = phoneNumController.text.trim();
                              });

                              final snackBar = SnackBar(
                                duration: const Duration(seconds: 1),
                                content: Text(
                                  "Updated",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: kBlack,
                                  ),
                                ),
                                backgroundColor: (Colors.red),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pop(
                                context,
                                Contacts(
                                  id: widget.id,
                                  firstName: widget.fName,
                                  lastName: widget.lName,
                                  email: widget.email,
                                  phoneNumber: widget.pNum,
                                  imagePath: widget.image,
                                ),
                              );
                              //);
                            }
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 15,
                              color: kVisaGold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.image,
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Center(
                        child: Text(
                          "${widget.fName} ${widget.lName}",
                          style: TextStyle(
                            color: kWhite,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                color: kVisaGold,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.yellow,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                ),
                                hintText: widget.fName,
                                labelText: 'First name',
                                // label: Text(widget.fName),
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty || value.trim().length == 0) {
                                  firstNameController.text = widget.fName;
                                  return null; //'Please enter your first name.';
                                } else {
                                  firstNameController.text =
                                      value.toString().trim();
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                color: kVisaGold,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.yellow,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                ),
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintText: widget.lName,
                                labelText: 'Last name',
                              ),
                              validator: (value) {
                                if (value.isEmpty || value.trim().length == 0) {
                                  lastNameController.text = widget.lName;
                                  return null; //'Please enter your last name.';
                                } else {
                                  lastNameController.text =
                                      value.toString().trim();
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                color: kVisaGold,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              maxLength: 10,
                              decoration: InputDecoration(
                                counterStyle: TextStyle(color: kVisaGold),
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.yellow,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                ),
                                hintText: widget.pNum,
                                labelText: 'Phone number',
                                // errorStyle: TextStyle(color: Colors.red),
                              ),
                              validator: (value) {
                                if (value.isEmpty || value.trim().length == 0) {
                                  phoneNumController.text = widget.pNum;
                                  return null;
                                  //'Please enter your phone number.';
                                } else if (value.length != 10) {
                                  return "Please check phone number";
                                } else {
                                  phoneNumController.text =
                                      value.toString().trim();
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              style: TextStyle(
                                color: kVisaGold,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.yellow,
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                ),
                                hintText: widget.email,
                                labelText: 'E-mail Address',
                              ),
                              validator: (value) {
                                if (value.isEmpty || value.trim().length == 0) {
                                  emailController.text = widget.email;
                                  return null; //'Please enter your email.';
                                } else if (!value.contains("@") ||
                                    !value.contains(".")) {
                                  return 'Please check email';
                                } else {
                                  emailController.text =
                                      value.toString().trim();
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                        ],
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
