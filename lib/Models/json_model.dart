class Contacts {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String imagePath;

  const Contacts({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.imagePath,
    this.phoneNumber,
  });

  static Contacts fromJson(json) => Contacts(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNum"],
        imagePath: json["imagePath"],
      );
}
