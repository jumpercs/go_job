import 'package:flutter/material.dart';
import 'package:go_job/models/scort_model.dart';

class ScortDetailsPage extends StatelessWidget {
  const ScortDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ScortModel scort =
        ModalRoute.of(context)?.settings.arguments as ScortModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(scort.name),
      ),
      body: Column(
        children: [
          Image.network(scort.photos[0]),
          Text(scort.name),
          Text(scort.description),
          Text(scort.category),
          Text(scort.rating.toString()),
          Text(scort.hourlyRate.toString()),
          Text(scort.availability.join(', ')),
          Text(scort.location.toString()),
          Text(scort.servicesOffered.join(', ')),
          Text(scort.physicalAttributes.toString()),
          Text(scort.personalityTraits.join(', ')),
          // Add a button to book the scort
          ElevatedButton(
            onPressed: () {
              // Add the code to book the scort
            },
            child: const Text(''),
          ),
        ],
      ),
    );
  }
}

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
                      "Message",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                      child: Text(
                    "Feeds",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
