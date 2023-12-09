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
          backgroundColor: Colors.indigo[900],
        ),
        backgroundColor: Colors.indigo[900],
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                Container(
                  color: Colors.indigo[800],
                  child: Row(
                    children: [
                      const Padding(padding: EdgeInsets.all(14)),
                      Container(
                        width: 200,
                        child: TextField(
                          controller: userController,
                          decoration: InputDecoration(
                            hintText: 'Search GitHub profile',
                            hintStyle: const TextStyle(color: Colors.white),
                            icon: const Icon(Icons.search),
                            iconColor: Colors.blue[700],
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(30)),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            httpRequest();
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue,
                          )),
                          child: const Text(
                            'Search',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  color: Colors.indigo[800],
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  profile!.avatar,
                                ),
                              ),
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Bio: ${profile!.bio}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Localização: ${profile!.location}',
                            style: const TextStyle(color: Colors.white),
                          ),
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
