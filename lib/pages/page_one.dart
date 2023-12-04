import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_api/models/profile.dart';
import 'package:http/http.dart' as http;

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  TextEditingController userController = TextEditingController();
  Profile? profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('devfinder', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blueGrey[600],
        ),
        backgroundColor: Colors.blueGrey[700],
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(14)),
                Container(
                  color: Colors.blueGrey[600],
                  child: Row(
                    children: [
                      const Padding(padding: EdgeInsets.all(14)),
                      Container(
                        width: 200,
                        child: TextField(
                          controller: userController,
                          decoration: const InputDecoration(
                            hintText: 'Search GitHub',
                            hintStyle: TextStyle(color: Colors.white),
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(30)),
                      Container(
                        child: ElevatedButton(
                            onPressed: () {
                              httpRequest();
                            },
                            child: const Text('Pesquisar')),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  color: Colors.blueGrey[600],
                  height: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.all(10)),
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.all(16)),
                          if (profile == null) ...[
                            const Icon(
                              Icons.account_box,
                              size: 100,
                            )
                          ],
                          if (profile != null) ...[
                            Container(
                              width: 100,
                              height: 100,
                              child: Image.network(profile!.avatar),
                            ),
                            const Padding(padding: EdgeInsets.all(5)),
                            Text(
                              'Nome: ${profile!.name}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ],
                      ),
                      if (profile != null) ...[
                        const Padding(padding: EdgeInsets.all(10)),
                        Text(
                          'Localização: ${profile!.location}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Text(
                          'Biográfia: ${profile!.bio}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void httpRequest() async {
    String user = userController.text;
    Uri url = Uri.parse('https://api.github.com/users/$user');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);
      profile = Profile.fromJson(decode);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao carregar informações')));
    }
    setState(() {});
  }
}
