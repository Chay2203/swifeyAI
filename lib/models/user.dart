class UserModel {
  String? email;
  String? name;
  DateTime? dateOfBirth;
  String? gender;
  String? college;
  String? company;

  UserModel({
    this.email,
    this.name,
    this.dateOfBirth,
    this.gender,
    this.college,
    this.company,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'college': college,
      'company': company,
    };
  }
}