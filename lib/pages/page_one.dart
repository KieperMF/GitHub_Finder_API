import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_api/models/profile.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  TextEditingController userController = TextEditingController();
  Profile? profile;
  String? formattedDate;

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
                      const Padding(padding: EdgeInsets.all(10)),
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
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.indigo[800],
                  ),
                  height: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.all(10)),
                      Row(
                        children: [
                          const Padding(padding: EdgeInsets.all(10)),
                          if (profile == null) ...[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: const Icon(
                                Icons.account_circle,
                                size: 100,
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(5)),
                            const Column(
                              children: [
                                Text(
                                  'Name:',
                                  style: TextStyle(color: Colors.white),
                                ),
                               Padding(padding: EdgeInsets.all(5)),
                                Text(
                                  'Joined:',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                          if (profile != null) ...[
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  profile!.avatar,
                                ),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.all(5)),
                            SizedBox(
                              width: 150,
                              child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                  'Name:\n ${profile!.name}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                ),
                                
                                const Padding(padding: EdgeInsets.all(5)),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                  'Joined:\n ${formattedDate}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                ),
                                
                              ],
                            ), 
                            ),
                            
                          ],
                        ],
                      ),
                      if (profile != null) ...[
                        const Padding(padding: EdgeInsets.all(10)),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Bio: ${profile!.bio}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(5)),
                        Container(
                          height: 60,
                          width: 320,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[900],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      "Repos",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '${profile!.repos}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(10)),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      "Followers",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '${profile!.followers}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(10)),
                              Expanded(
                                child: Column(
                                  children: [
                                    const Text(
                                      "Following",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '${profile!.following}',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(5)),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Location: ${profile!.location}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                      if (profile == null) ...[
                        const Padding(padding: EdgeInsets.all(10)),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Bio:',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(5)),
                        Container(
                          height: 50,
                          width: 320,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[900],
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Repos",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10)),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Followers",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10)),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Following",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(5)),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Location:',
                              style: TextStyle(color: Colors.white),
                            ),
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
    DateTime joined = DateTime.parse(profile!.date);
    formattedDate = DateFormat('dd/MM/yyyy').format(joined);
    setState(() {});
  }
}
