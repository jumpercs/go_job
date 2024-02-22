import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_job/models/user_register_model.dart';
import 'package:image_picker/image_picker.dart';

class CreateUserFirebase extends StatefulWidget {
  const CreateUserFirebase({super.key});

  @override
  State<CreateUserFirebase> createState() => _CreateUserFirebaseState();
}

class _CreateUserFirebaseState extends State<CreateUserFirebase> {
  late UserRegister userRegister;

  Future<void> createUser(UserRegister user) async {
    // Create a local instance of Firebase
    FirebaseApp localApp = await Firebase.initializeApp(
      name: 'Local',
      options: Firebase.app().options,
    );

    try {
      FirebaseAuth localAuth = FirebaseAuth.instanceFor(app: localApp);
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FirebaseStorage storage = FirebaseStorage.instance;

      // Create a new user with email and password
      UserCredential userCredential =
          await localAuth.createUserWithEmailAndPassword(
        email: user.email!,
        password: user.password!, // Using CPF as password for the example
      );

      // Upload profile pics to Firebase Storage and get download URLs
      List<String> profilePicUrls = [];
      for (XFile profilePic
          in user.profilePics!.map((file) => XFile(file.path))) {
        File file = File(profilePic.path);
        TaskSnapshot snapshot = await storage
            .ref(
                'profilePics/${userCredential.user!.uid}/${DateTime.now().toIso8601String()}')
            .putFile(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        profilePicUrls.add(downloadUrl);
      }

      // Upload user verification photo to Firebase Storage and get download URL
      File userVerificationPhotoFile = File(user.userVerificationPhoto!.path);
      TaskSnapshot userVerificationPhotoSnapshot = await storage
          .ref('userVerificationPhotos/${userCredential.user!.uid}')
          .putFile(userVerificationPhotoFile);
      String userVerificationPhotoUrl =
          await userVerificationPhotoSnapshot.ref.getDownloadURL();

      // Upload verification document photo to Firebase Storage and get download URL
      File verificationDocumentPhotoFile =
          File(user.verificationDocumentPhoto!.path);
      TaskSnapshot verificationDocumentPhotoSnapshot = await storage
          .ref('verificationDocumentPhotos/${userCredential.user!.uid}')
          .putFile(verificationDocumentPhotoFile);
      String verificationDocumentPhotoUrl =
          await verificationDocumentPhotoSnapshot.ref.getDownloadURL();

      // Create a new document with the user details in Firestore
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': user.fullName,
        'email': user.email,
        'cpf': user.password, // Assuming CPF is stored in password
        'birthDate': user.birthDate!.toIso8601String(),
        'profilePics': profilePicUrls,
        'userVerificationPhoto': userVerificationPhotoUrl,
        'verificationDocumentPhoto': verificationDocumentPhotoUrl,
        'isVerified': false,
      });

      // Delete the local instance
      await localApp.delete();

      print('Usuário criado com sucesso');
    } catch (e) {
      // Delete the local instance
      await localApp.delete();
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userRegister = ModalRoute.of(context)!.settings.arguments as UserRegister;
    });
    return Container(
      child: Center(
        child: Column(
          children: [
            Text('Criando usuário no Firebase'),
            ElevatedButton(
              onPressed: () async {
                await createUser(userRegister);
              },
              child: Text('Criar usuário'),
            ),
          ],
        ),
      ),
    );
  }
}
