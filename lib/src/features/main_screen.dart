import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _citycodeController = TextEditingController();
  Future<String>? _city;

  // TODO skiped
  // don't see reason to initialize controllers over initState
  // @override
  // void initState() {
  //   super.initState();
  //   _city = getCityFromZip('');
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  controller: _citycodeController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Postleitzahl"),
                ),
                const SizedBox(height: 32),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      // get result from input
                      _city = getCityFromZip(_citycodeController.text);
                    });
                  },
                  child: const Text("Suche"),
                ),
                const SizedBox(height: 32),
                // FutureBuilder to see whats up
                FutureBuilder(
                    future: _city,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
                          snapshot.hasData) {
                        return Text(snapshot.data.toString());
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
                          snapshot.hasError) {
                        return Text('Fehler: ${snapshot.error}');
                      } else {
                        // output after start/hot reload
                        return const Text('Noch keine PLZ gesucht');
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    citycodeController.dispose();
    super.dispose();
  }

  Future<String> getCityFromZip(String zip) async {
    // simuliere Dauer der Datenbank-Anfrage
    await Future.delayed(const Duration(seconds: 3));
    print('$zip zip');

    switch (zip) {
      case "10115":
        return 'Berlin';
      case "20095":
        return 'Hamburg';
      case "80331":
        return 'München';
      case "50667":
        return 'Köln';
      case "60311":
      case "60313":
        return 'Frankfurt am Main';
      default:
        return 'Unbekannte Stadt';
    }
  }
}
