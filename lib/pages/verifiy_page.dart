import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VerificationPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .where('isVerified', isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Card(
                child: InkWell(
                  onTap: () {
                    //faça um modal deslizante com os dados do usuário e a opção de verificar

                    // await document.reference.update({'isVerified': true});

                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(data['fullName']),
                                  Text(data['email']),
                                  Text(data['cpf']),
                                  //birthDate dd/MM/yyyy
                                  Text(data['birthDate']),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("Foto do usuário"),
                                          Image(
                                            width: 100,
                                            image: NetworkImage(
                                              data['userVerificationPhoto'],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text("Foto do documento"),
                                          Image(
                                            width: 100,
                                            image: NetworkImage(
                                              data['verificationDocumentPhoto'],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    child: Text('Verify'),
                                    onPressed: () async {
                                      await document.reference
                                          .update({'isVerified': true});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['profilePics'][0]),
                        ),
                        title: Text(data['fullName']),
                        subtitle: Text(data['email']),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
