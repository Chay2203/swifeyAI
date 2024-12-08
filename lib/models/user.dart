class UserModel {
  String? userId;
  String? email;
  String? name;
  DateTime? dateOfBirth;
  String? gender;
  String? college;
  String? company;
  String? walletAddress;
  bool? stakingStatus;
  bool? chatHistoryPreference;
  List<String>? connectedUserIds;

  UserModel({
    this.userId,
    this.email,
    this.name,
    this.dateOfBirth,
    this.gender,
    this.college,
    this.company,
    this.walletAddress,
    this.stakingStatus = false,
    this.chatHistoryPreference = true,
    this.connectedUserIds, 
  }) {
    connectedUserIds ??= [];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'college': college,
      'company': company,
      'walletAddress': walletAddress,
      'stakingStatus': stakingStatus,
      'chatHistoryPreference': chatHistoryPreference,
      'connectedUserIds': connectedUserIds,
    };
  }
}
