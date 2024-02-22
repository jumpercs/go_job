import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_job/models/scort_model.dart';
import 'package:go_job/pages/account_tab.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ScortModel> _scorts = [
    ScortModel(
      scortID: '1',
      name: 'Maria da Silva',
      description:
          'Massagista profissional com experiência em eventos corporativos.',
      category: 'Massagem e Acompanhamento em Eventos',
      rating: 4.8,
      hourlyRate: 50.0,
      availability: ['Segunda-feira', 'Quarta-feira', 'Sábado'],
      location: GeoPoint(0.0, 0.0),
      servicesOffered: ['Massagem relaxante', 'Massagem terapêutica'],
      physicalAttributes: {'height': '1.65m', 'hairColor': 'Castanho'},
      personalityTraits: ['Amigável', 'Profissional', 'Atenciosa'],
      photos: [
        'https://randomuser.me/api/portraits/women/72.jpg',
        'https://randomuser.me/api/portraits/women/15.jpg'
      ],
    ),
    ScortModel(
        scortID: '2',
        name: 'Joana da Silva',
        description:
            'Massagista profissional com experiência em eventos corporativos.',
        category: 'Massagem e Acompanhamento em Eventos',
        rating: 4.8,
        hourlyRate: 50.0,
        availability: ['Segunda-feira', 'Quarta-feira', 'Sábado'],
        location: GeoPoint(0.0, 0.0),
        servicesOffered: ['Massagem relaxante', 'Massagem terapêutica'],
        physicalAttributes: {'height': '1.65m', 'hairColor': 'Loiro'},
        personalityTraits: ['Amigável', 'Profissional', 'Atenciosa'],
        photos: [
          'https://randomuser.me/api/portraits/women/77.jpg',
        ]),
    ScortModel(
      scortID: '3',
      name: 'Ana Carolina',
      description:
          'Massagista profissional com experiência em eventos corporativos.',
      category: 'Massagem e Acompanhamento em Eventos',
      rating: 4.8,
      hourlyRate: 50.0,
      availability: ['Segunda-feira', 'Quarta-feira', 'Sábado'],
      location: GeoPoint(0.0, 0.0),
      servicesOffered: ['Massagem relaxante', 'Massagem terapêutica'],
      physicalAttributes: {'height': '1.65m', 'hairColor': 'Castanho'},
      personalityTraits: ['Amigável', 'Profissional', 'Atenciosa'],
      photos: ['https://randomuser.me/api/portraits/women/78.jpg'],
    ),
    ScortModel(
      scortID: '4',
      name: 'Maria da Silva',
      description:
          'Massagista profissional com experiência em eventos corporativos.',
      category: 'Massagem e Acompanhamento em Eventos',
      rating: 4.8,
      hourlyRate: 50.0,
      availability: ['Segunda-feira', 'Quarta-feira', 'Sábado'],
      location: GeoPoint(0.0, 0.0),
      servicesOffered: ['Massagem relaxante', 'Massagem terapêutica'],
      physicalAttributes: {'height': '1.65m', 'hairColor': 'Castanho'},
      personalityTraits: ['Amigável', 'Profissional', 'Atenciosa'],
      photos: ['https://randomuser.me/api/portraits/women/79.jpg'],
    ),
    ScortModel(
      scortID: '5',
      name: 'Maria da Silva',
      description:
          'Massagista profissional com experiência em eventos corporativos.',
      category: 'Massagem e Acompanhamento em Eventos',
      rating: 4.8,
      hourlyRate: 50.0,
      availability: ['Segunda-feira', 'Quarta-feira', 'Sábado'],
      location: GeoPoint(0.0, 0.0),
      servicesOffered: ['Massagem relaxante', 'Massagem terapêutica'],
      physicalAttributes: {'height': '1.65m', 'hairColor': 'Castanho'},
      personalityTraits: ['Amigável', 'Profissional', 'Atenciosa'],
      photos: ['https://randomuser.me/api/portraits/women/80.jpg'],
    ),
    ScortModel(
      scortID: '6',
      name: 'Maria da Silva',
      description:
          'Massagista profissional com experiência em eventos corporativos.',
      category: 'Massagem e Acompanhamento em Eventos',
      rating: 4.8,
      hourlyRate: 50.0,
      availability: ['Segunda-feira', 'Quarta-feira', 'Sábado'],
      location: GeoPoint(0.0, 0.0),
      servicesOffered: ['Massagem relaxante', 'Massagem terapêutica'],
      physicalAttributes: {'height': '1.65m', 'hairColor': 'Castanho'},
      personalityTraits: ['Amigável', 'Profissional', 'Atenciosa'],
      photos: ['https://randomuser.me/api/portraits/women/81.jpg'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                indicator: BoxDecoration(color: Colors.transparent),
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.red[400],
                tabs: const [
                  Tab(
                    child: Text(
                      "PUTAS",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                      child: Text(
                    "CHATS",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  Tab(
                      child: Text(
                    "PERFIL",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildBody(context),
            Icon(Icons.chat),
            AccountTab()
          ],
        ),
      ),
    );

    Scaffold(
      appBar: AppBar(
        title: //firebase auth user name),
            Text(FirebaseAuth.instance.currentUser!.email.toString()),
        actions: [
          //signoff
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              //firebase signoff
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.red,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _scorts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        return _buildCard(context, _scorts[index]);
      },
    );
  }

  Widget _buildCard(BuildContext context, ScortModel scort) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/scort_details', arguments: scort);
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            _buildImage(scort.photos.first),
            Container(
              height: 80.0,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildNome(scort.name),
                  _buildValor(scort.hourlyRate),
                  Text(
                    '2KM de distância',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String url) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildNome(String nome) {
    return Text(
      nome,
      style: const TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildValor(double hourlyRate) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        'R\$ ${hourlyRate.toStringAsFixed(2)}/hora',
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.grey,
        ),
      ),
    );
  }
}
