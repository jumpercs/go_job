import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_job/models/user_model.dart';
import 'package:go_job/models/user_register_model.dart';
import 'package:go_job/providers/user_provider.dart';
import 'package:provider/provider.dart';

final Widget placeholder = Container(color: Colors.grey);

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class AccountTab extends StatefulWidget {
  @override
  _AccountTabState createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  int _current = 0;

  Widget swipeWidgetText(upperText, [lowerText = ""]) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 6,
              ),
              Text(
                upperText,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            lowerText,
            style: TextStyle(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<UserModel> getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get the currently logged in user
    User? firebaseUser = auth.currentUser;

    if (firebaseUser != null) {
      // Get the user document from Firestore
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(firebaseUser.uid).get();

      if (userDoc.exists) {
        // Convert the document to a UserModel object
        UserModel user =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

        return user;
      } else {
        throw Exception('User document does not exist');
      }
    } else {
      throw Exception('No user is currently logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserModel>(
        future: getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Os dados ainda estão carregando
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Ocorreu um erro ao carregar os dados
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Os dados foram carregados com sucesso
            UserModel user = snapshot.data!;
            DateTime birthDate = DateTime.parse(user.birthDate);
            int age = DateTime.now().year - birthDate.year;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ClipPath(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 16),
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: Image.network(
                              user.profilePics.first,
                            ).image,
                            backgroundColor: Colors.transparent,
                          ),
                          SizedBox(height: 8),
                          Text(
                            user.fullName.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            age.toString() + " anos",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.settings,
                                            color: Colors.grey, size: 30),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        "CONFIG",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 36, 0, 0),
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromRGBO(253, 41, 123, 1),
                                              Color.fromRGBO(255, 88, 100, 1),
                                              Color.fromRGBO(255, 101, 91, 1)
                                            ],
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                          ),
                                        ),
                                        child: Icon(Icons.add,
                                            color: Colors.white, size: 30),
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      "FOTOS",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  //signoff firebase
                                  FirebaseAuth.instance.signOut();
                                },
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.edit,
                                            color: Colors.grey, size: 30),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        "EDITAR",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 86),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  CarouselSlider(
                    items: [
                      swipeWidgetText(
                        "Descubra Novas Acompanhantes!",
                        "Encontre acompanhantes deslumbrantes e experientes prontas para realizar suas fantasias.",
                      ),
                      swipeWidgetText(
                        "Massagens Relaxantes",
                        "Relaxe e renove suas energias com uma variedade de massagens terapêuticas oferecidas por profissionais qualificados.",
                      ),
                      swipeWidgetText(
                        "Agende uma Sessão VIP!",
                        "Desfrute de uma experiência de acompanhamento exclusiva com nossa opção VIP. Reserve agora!",
                      ),
                      swipeWidgetText(
                        "Encontre o Equilíbrio Interior",
                        "Explore nossas massagens holísticas projetadas para promover o bem-estar físico e mental.",
                      ),
                    ],
                    options:
                        CarouselOptions(autoPlay: true, viewportFraction: 0.95),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
