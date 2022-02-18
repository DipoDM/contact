import 'package:contact/Controllers/constants.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNum;
  final String imagePath;
  const ContactCard({
    Key key,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNum,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      child: SizedBox.square(
        // height: 150,
        child: ExcludeSemantics(
          child: Card(
            elevation: 5,
            color: kVisaGold,
            shadowColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Semantics(
                      image: true,
                      child: Image.asset(
                        imagePath != ""
                            ? imagePath
                            : "assets/images/profile.jpg",
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: Text(
                            "$firstName $lastName",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.phone_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: FittedBox(
                                child: Text(
                                  phoneNum,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.email_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: FittedBox(
                                child: Text(
                                  email,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
