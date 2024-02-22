import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_job/models/user_register_model.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final emailController = TextEditingController();
  DateTime? nascimentoController;
  final passwordController = TextEditingController();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Nome completo',
                  border: OutlineInputBorder() // Add this line
                  ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: cpfController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CPF',
                hintText: '000.000.000-00',
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  // minimo 18 anos
                  if (DateTime.now().difference(pickedDate).inDays < 6570) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Você deve ter no mínimo 18 anos'),
                      ),
                    );
                  } else {
                    nascimentoController = pickedDate;
                    setState(() {});
                  }
                }
              },
              child: Text(nascimentoController == null
                  ? 'Data de nascimento'
                  : '${nascimentoController!.day}/${ // two digits day
                  nascimentoController!.month}/${nascimentoController!.year}'),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )),
              obscureText: _isObscure,
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                var model = UserRegister(
                  fullName: nameController.text,
                  cpf: cpfController.text,
                  birthDate: nascimentoController,
                  email: emailController.text,
                  password: passwordController.text,
                );
                Navigator.pushNamed(context, '/user-photo', arguments: model);
              },
              child: const Text('Próximo passo'),
            ),
          ],
        ),
      ),
    );
  }
}
