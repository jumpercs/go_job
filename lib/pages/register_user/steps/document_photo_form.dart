import 'package:flutter/material.dart';
import 'package:go_job/models/user_register_model.dart';
import 'package:image_picker/image_picker.dart';

class DocumentPhotoForm extends StatefulWidget {
  const DocumentPhotoForm({super.key});

  @override
  State<DocumentPhotoForm> createState() => _DocumentPhotoFormState();
}

class _DocumentPhotoFormState extends State<DocumentPhotoForm> {
  late UserRegister userRegister;
  navigate(model) {
    Navigator.pushNamed(context, '/finish', arguments: model);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userRegister = ModalRoute.of(context)?.settings.arguments as UserRegister;
    });

    return Container(
      child: Center(
        child: Column(
          children: [
            Text('Tire uma foto do seu documento'),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  var model = userRegister.copyWith(
                    verificationDocumentPhoto: image,
                  );
                  navigate(model);
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
