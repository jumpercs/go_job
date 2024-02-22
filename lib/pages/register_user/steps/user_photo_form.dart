import 'package:flutter/material.dart';
import 'package:go_job/models/user_register_model.dart';
import 'package:image_picker/image_picker.dart';

class UserPhotoForm extends StatefulWidget {
  const UserPhotoForm({super.key});

  @override
  State<UserPhotoForm> createState() => _UserPhotoFormState();
}

class _UserPhotoFormState extends State<UserPhotoForm> {
  late UserRegister userRegister;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userRegister = ModalRoute.of(context)!.settings.arguments as UserRegister;
    });
    return Container(
      child: Center(
        child: Column(
          children: [
            Text('Tire uma foto sua'),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  var model = userRegister.copyWith(
                    userVerificationPhoto: image,
                  );
                  Navigator.pushNamed(context, '/document-photo',
                      arguments: model);
                }
              },
              child: Text('Tirar foto'),
            ),
          ],
        ),
      ),
    );
  }
}
