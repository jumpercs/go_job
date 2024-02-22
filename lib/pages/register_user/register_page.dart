// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// import 'package:flutter/material.dart';

// class SignUpPage extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _picker = ImagePicker();
//   File? _userImageFile;
//   File? _documentImageFile;
//   final _fullName = TextEditingController();
//   final _cpf = TextEditingController();
//   final _email = TextEditingController();
//   final _password = TextEditingController();

//   DateTime? _bornDate;

//   Future<String> uploadImage(File imageFile) async {
//     String fileName = DateTime.now().millisecondsSinceEpoch.toString();

//     FirebaseStorage storage = FirebaseStorage.instance;
//     Reference ref = storage.ref().child('images/$fileName');
//     UploadTask uploadTask = ref.putFile(imageFile);

//     await uploadTask.whenComplete(() => null);
//     String downloadUrl = await ref.getDownloadURL();

//     return downloadUrl;
//   }

//   Future<UserCredential> createUser(String email, String password) async {
//     FirebaseAuth auth = FirebaseAuth.instanceFor(app: Firebase.app());
//     UserCredential userCredential = await auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return userCredential;
//   }

//   Future<void> createUserDocument(String userId, String fullName, String cpf,
//       String email, String userPhotoUrl, String documentPhotoUrl) async {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');
//     await users.doc(userId).set({
//       'fullName': fullName,
//       'cpf': cpf,
//       'email': email,
//       'userPhotoUrl': userPhotoUrl,
//       'documentPhotoUrl': documentPhotoUrl,
//       'isVerified': false,
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: EdgeInsets.all(16.0),
//           children: <Widget>[
//             // Full Name
//             TextFormField(
//               controller: _fullName,
//               decoration: InputDecoration(labelText: 'Full Name'),
//               validator: (value) =>
//                   value!.isEmpty ? 'Please enter your full name.' : null,
//               onSaved: (value) => _fullName.text = value!,
//             ),
//             // Date of Birth
//             ElevatedButton(
//               child: Text('Select Date of Birth'),
//               onPressed: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(1900),
//                   lastDate: DateTime.now(),
//                 );
//                 if (pickedDate != null) {
//                   setState(() {
//                     _bornDate = pickedDate;
//                   });
//                 }
//               },
//             ),
//             // CPF
//             TextFormField(
//               controller: _cpf,
//               decoration: InputDecoration(labelText: 'CPF'),
//               validator: (value) =>
//                   value!.isEmpty ? 'Please enter your CPF.' : null,
//               onSaved: (value) => _cpf.text = value!,
//             ),
//             // Email
//             TextFormField(
//               controller: _email,
//               decoration: InputDecoration(labelText: 'Email'),
//               validator: (value) =>
//                   value!.isEmpty ? 'Please enter your email.' : null,
//               onSaved: (value) => _email.text = value!,
//             ),
//             // Password
//             TextFormField(
//               controller: _password,
//               decoration: InputDecoration(labelText: 'Password'),
//               obscureText: true,
//               validator: (value) =>
//                   value!.isEmpty ? 'Please enter your password.' : null,
//               onSaved: (value) => _password.text = value!,
//             ),
//             // User Photo
//             ElevatedButton(
//               child: Text('Upload User Photo'),
//               onPressed: () async {
//                 final pickedFile =
//                     await _picker.pickImage(source: ImageSource.gallery);
//                 setState(() {
//                   if (pickedFile != null) {
//                     _userImageFile = File(pickedFile.path);
//                   }
//                 });
//               },
//             ),
//             if (_userImageFile != null) Image.file(_userImageFile!),
//             // Document Photo
//             ElevatedButton(
//               child: Text('Upload Document Photo'),
//               onPressed: () async {
//                 final pickedFile =
//                     await _picker.pickImage(source: ImageSource.gallery);
//                 setState(() {
//                   if (pickedFile != null) {
//                     _documentImageFile = File(pickedFile.path);
//                   }
//                 });
//               },
//             ),
//             if (_documentImageFile != null) Image.file(_documentImageFile!),

//             // Submit
//             ElevatedButton(
//               child: Text('Sign Up'),
//               onPressed: () async {
//                 if (_bornDate == null) {
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text('Please select your date of birth.'),
//                   ));
//                   return;
//                 }
//                 // maior de 18 anos
//                 if (DateTime.now().difference(_bornDate!).inDays < 6570) {
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                     content: Text('You must be at least 18 years old.'),
//                   ));
//                   return;
//                 }

//                 if (_formKey.currentState!.validate()) {
//                   _formKey.currentState!.save();
//                   UserCredential userCredential =
//                       await createUser(_email.text, _password.text);
//                   String userPhotoUrl = await uploadImage(_userImageFile!);
//                   String documentPhotoUrl =
//                       await uploadImage(_documentImageFile!);

//                   await createUserDocument(
//                       userCredential.user!.uid,
//                       _fullName.text,
//                       _cpf.text,
//                       _email.text,
//                       userPhotoUrl,
//                       documentPhotoUrl);
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_job/pages/register_user/steps/create_user_firebase.dart';
import 'package:go_job/pages/register_user/steps/document_photo_form.dart';
import 'package:go_job/pages/register_user/steps/finish_form.dart';
import 'package:go_job/pages/register_user/steps/sign_up_form.dart';
import 'package:go_job/pages/register_user/steps/user_photo_form.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canPop = navigatorKey.currentState?.canPop() ?? false;
        if (canPop) {
          navigatorKey.currentState!.pop();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Olá, seja bem-vindo!'),
        ),
        body: Navigator(
          key: navigatorKey,
          initialRoute: '/personal-data',
          onGenerateRoute: (settings) {
            var route = settings.name;
            Widget page;
            switch (route) {
              case '/personal-data':
                page = SignUpForm();
                break;
              case '/user-photo':
                page = UserPhotoForm();
                break;
              case '/document-photo':
                page = DocumentPhotoForm();
                break;
              case '/finish':
                page = FinishForm();
                break;
              case '/create-user-firebase':
                page = CreateUserFirebase();
                break;
              default:
                return null;
            }

            return MaterialPageRoute(
              builder: (context) => page,
              settings: settings,
            );
          },
        ),
      ),
    );
  }
}
