import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_job/models/user_register_model.dart';
import 'package:image_picker/image_picker.dart';

class FinishForm extends StatefulWidget {
  const FinishForm({
    super.key,
  });

  @override
  State<FinishForm> createState() => _FinishFormState();
}

class _FinishFormState extends State<FinishForm> {
  late UserRegister userRegister;
  List<File> _profilePics = [];
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userRegister = ModalRoute.of(context)!.settings.arguments as UserRegister;
    });
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(
        child: Column(
          children: [
            Text('Adicione as fotos do seu perfil',
                style: TextStyle(fontSize: 20)),
            GridView.builder(
              shrinkWrap: true,
              itemCount: _profilePics.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (index == _profilePics.length) {
                  return IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    onPressed: () async {
                      final pickedFile =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          _profilePics.add(File(pickedFile.path));
                        });
                      }
                    },
                  );
                } else {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(_profilePics[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _profilePics.removeAt(index);
                          });
                        },
                      ),
                    ],
                  );
                }
              },
            ),
            ElevatedButton(
              onPressed: () async {
                var model = userRegister.copyWith(
                  profilePics: _profilePics,
                );
                Navigator.pushNamed(context, '/create-user-firebase',
                    arguments: model);
              },
              child: Text('Finalizar cadastro'),
            ),
          ],
        ),
      ),
    );
  }
}
