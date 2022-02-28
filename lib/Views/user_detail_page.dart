import 'package:contact/Controllers/apiprovider.dart';
import 'package:contact/Views/edit_detail_page.dart';
import 'package:contact/Widgets/label_hint.dart';
import 'package:contact/Widgets/label_name.dart';
import 'package:contact/Widgets/media_button.dart';
import 'package:contact/Controllers/constants.dart';
import 'package:contact/Models/json_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailPage extends StatefulWidget {
  String id;
  String fName;
  String lName;
  String pNum;
  String image;
  String email;

  DetailPage({
    Key key,
    this.id,
    this.fName,
    this.lName,
    this.pNum,
    this.image,
    this.email,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  void updateInformation(Contacts _cons) {
    _cons == null
        ? null
        : setState(() {
            widget.id = _cons.id;
            widget.fName = _cons.firstName;
            widget.lName = _cons.lastName;
            widget.email = _cons.email;
            widget.image = _cons.imagePath;
            widget.pNum = _cons.phoneNumber;
          });
  }

  void moveToSecondPage() async {
    final information = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(
          id: widget.id,
          fName: widget.fName,
          lName: widget.lName,
          email: widget.email,
          pNum: widget.pNum,
          image: widget.image,
        ),
      ),
    );
    updateInformation(information);
  }

  void selectedItem(
    BuildContext context,
    item,
  ) {
    switch (item) {
      case 0:
        moveToSecondPage();
        break;
      case 1:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Confirm delete",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: kBlack,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final ContacLi contactStateNotifier =
                              ref.watch(contactsStateList.notifier);
                          return ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            onPressed: () {
                              Navigator.pop(context);
                              contactStateNotifier.remove(
                                  num: Contacts(
                                id: widget.id,
                              ));

                              final snackBar = SnackBar(
                                content: Text(
                                  "Deleted",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: kBlack,
                                  ),
                                ),
                                duration: const Duration(seconds: 1),
                                backgroundColor: (Colors.red),
                                action: SnackBarAction(
                                  label: 'undo',
                                  textColor: kWhite,
                                  onPressed: () {},
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: kWhite,
                              ),
                            ),
                          );
                        },
                        //child:
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: kWhite,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kVisaBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.more_horiz,
                    color: kWhite,
                  ),
                ),
              ),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(
                  value: 0,
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
              onSelected: (item) => selectedItem(context, item),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Semantics(
                label: "${widget.fName} ${widget.lName} image",
                image: true,
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Center(
              child: Text(
                "${widget.fName} ${widget.lName}",
                textAlign: TextAlign.center,
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
          Wrap(
            alignment: WrapAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MediaButton(
                buttonIcon: Icons.message_outlined,
                buttonName: "Message",
                action: () {},
                semanticLabel: widget.fName,
              ),
              MediaButton(
                buttonIcon: Icons.video_call_outlined,
                buttonName: "Video Call",
                action: () {},
                semanticLabel: widget.fName,
              ),
              MediaButton(
                buttonIcon: Icons.phone_outlined,
                buttonName: "Call",
                action: () {},
                semanticLabel: widget.fName,
              ),
              MediaButton(
                buttonIcon: Icons.email_outlined,
                buttonName: "Mail",
                action: () {},
                semanticLabel: widget.fName,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LabelHint(
                  displayText: "FULL NAME",
                ),
                Semantics(
                  label: "Full name is ${widget.fName} ${widget.lName}",
                  child: LabelName(
                    labelText: widget.fName + " " + widget.lName,
                  ),
                ),
                const LabelHint(
                  displayText: "PHONE NUMBER",
                ),
                Semantics(
                  label: "Phone number is ${widget.pNum}",
                  child: LabelName(
                    labelText: widget.pNum,
                  ),
                ),
                const LabelHint(
                  displayText: "EMAIL ADDRESS",
                ),
                Semantics(
                  label: "Email address is ${widget.email}",
                  child: LabelName(
                    labelText: widget.email,
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
    );
  }
}
