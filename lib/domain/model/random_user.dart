class RandomUser {
  final String firstName;
  final String lastName;
  final String gender;
  final String phone;
  final String email;
  final String imageUrl;
  final int age;

  RandomUser(
      {required this.firstName,
      required this.lastName,
      required this.age,
      required this.gender,
      required this.phone,
      required this.email, required this.imageUrl});

  factory RandomUser.fromJson(Map<String, dynamic> json) => RandomUser(
      firstName: json['name']['first'] ?? '',
      lastName: json['name']['last'] ?? '',
      age: json['dob']['age'] ?? '',
      gender: json['gender'] ?? '',
      phone: json['cell'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['picture']['medium'] ?? ''
  );

  @override
  String toString() {
    return 'RandomUser{firstName: $firstName, lastName: $lastName, age: $age, gender: $gender, phone: $phone, email: $email}';
  }
}
