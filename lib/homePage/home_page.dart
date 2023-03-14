import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:precious_gifts/homePage/donate_page.dart';

void main() {
  runApp(const MyApp());
}

class Homes extends StatefulWidget {
  const Homes({Key? key}) : super(key: key);

  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  final CollectionReference _referenceHomes =
      FirebaseFirestore.instance.collection('Homes');
  late Stream<QuerySnapshot> _streamHomes;

  @override
  void initState() {
    super.initState();
    _streamHomes = _referenceHomes.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Children\'s Homes'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _referenceHomes.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (snapshot.connectionState == ConnectionState.active) {
            QuerySnapshot querySnapshot = snapshot.data!;
            List<QueryDocumentSnapshot> documents = querySnapshot.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
                QueryDocumentSnapshot document = documents[index];
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return ListTile(
                  leading: const Icon(Icons.home_rounded),
                  title: Text(data['name']),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(data['location']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text("${data['population']} children"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text("Directed by ${data['director']}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DonatePage(home: data),
                              ),
                            );
                          },
                          child: const Text('Donate'),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'About Us',
            icon: Icon(Icons.info),
          ),
          BottomNavigationBarItem(
            label: 'Sign out',
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Children\'s Homes',
      home: Homes(),
    );
  }
}
