class UserModel {
  String? userId;
  String? email;
  String? name;
  DateTime? dateOfBirth;
  String? gender;
  String? college;
  String? company;

  UserModel({
    this.userId,
    this.email,
    this.name,
    this.dateOfBirth,
    this.gender,
    this.college,
    this.company,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'college': college,
      'company': company,
    };
  }
}