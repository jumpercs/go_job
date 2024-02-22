class UserModel {
  final String fullName;
  final String email;
  final String cpf;
  final String birthDate;
  final List<String> profilePics;
  final String userVerificationPhoto;
  final String verificationDocumentPhoto;
  final bool isVerified;

  UserModel({
    required this.fullName,
    required this.email,
    required this.cpf,
    required this.birthDate,
    required this.profilePics,
    required this.userVerificationPhoto,
    required this.verificationDocumentPhoto,
    required this.isVerified,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      fullName: data['fullName'],
      email: data['email'],
      cpf: data['cpf'],
      birthDate: data['birthDate'],
      profilePics: List<String>.from(data['profilePics']),
      userVerificationPhoto: data['userVerificationPhoto'],
      verificationDocumentPhoto: data['verificationDocumentPhoto'],
      isVerified: data['isVerified'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'cpf': cpf,
      'birthDate': birthDate,
      'profilePics': profilePics,
      'userVerificationPhoto': userVerificationPhoto,
      'verificationDocumentPhoto': verificationDocumentPhoto,
      'isVerified': isVerified,
    };
  }
}
