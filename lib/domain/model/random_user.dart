class RandomUser {
  final String firstName;
  final String lastName;
  final String gender;
  final String phone;
  final String email;
  final String imageUrl;
  final int age;

  RandomUser({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.phone,
    required this.email,
    required this.imageUrl,
  });

  factory RandomUser.fromJson(Map<String, dynamic> json) => RandomUser(
        firstName: (json['name'] as Map<String, dynamic>)['first'] as String,
        lastName: (json['name'] as Map<String, dynamic>)['last'] as String,
        age: (json['dob'] as Map<String, dynamic>)['age'] as int,
        gender: json['gender'] as String,
        phone: json['cell'] as String,
        email: json['email'] as String,
        imageUrl: (json['picture'] as Map<String, dynamic>)['medium'] as String,
      );

  @override
  String toString() {
    return 'RandomUser{firstName: $firstName, lastName: $lastName, age: $age, gender: $gender, phone: $phone, email: $email}';
  }
}
