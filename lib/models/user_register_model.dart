import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UserRegister {
  final String? fullName;
  final String? email;
  final String? cpf;
  final String? password;
  final DateTime? birthDate;
  final List<File>? profilePics;
  final XFile? userVerificationPhoto;
  final XFile? verificationDocumentPhoto;

  UserRegister({
    this.fullName,
    this.email,
    this.cpf,
    this.birthDate,
    this.profilePics,
    this.userVerificationPhoto,
    this.verificationDocumentPhoto,
    this.password,
  });
//copy with
  UserRegister copyWith({
    String? fullName,
    String? email,
    String? cpf,
    String? password,
    DateTime? birthDate,
    List<File>? profilePics,
    XFile? userVerificationPhoto,
    XFile? verificationDocumentPhoto,
  }) {
    return UserRegister(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      password: password ?? this.password,
      birthDate: birthDate ?? this.birthDate,
      profilePics: profilePics ?? this.profilePics,
      userVerificationPhoto:
          userVerificationPhoto ?? this.userVerificationPhoto,
      verificationDocumentPhoto:
          verificationDocumentPhoto ?? this.verificationDocumentPhoto,
    );
  }

  static UserRegister fromMap(Object object) {
    final Map<String, dynamic> map = object as Map<String, dynamic>;
    return UserRegister(
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      cpf: map['cpf'] as String,
      birthDate: map['birthDate'] as DateTime,
      profilePics: map['profilePics'] as List<File>,
      userVerificationPhoto: map['userVerificationPhoto'] as XFile,
      verificationDocumentPhoto: map['verificationDocumentPhoto'] as XFile,
    );
  }
}
