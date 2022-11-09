import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quantum_assignment/models/article_model.dart';
import 'package:quantum_assignment/repository/news_api_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../services/firebase_auth_methods.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentDateTime = new DateTime.now();
  TextEditingController searchEditingController = TextEditingController();
  bool hasInternet = true;

  List<ArticleModel> newsList = [];
  List<ArticleModel> newsListOnSearch = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNewsApi();
  }

  void loadNewsApi() async {
    NewsApiRepsitory newsApiRepsitory = NewsApiRepsitory();
    await newsApiRepsitory.getNews();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      hasInternet = false;
    }
    newsList = newsApiRepsitory.newsList;
    setState(() {});

    print("---->" + newsList.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuthMethods(FirebaseAuth.instance).signOut(context);
              },
              icon: Icon(
                Icons.logout,
                color: Color(0xff1968b3),
              ))
        ],
        backgroundColor: Colors.white,
        title: TextField(
          controller: searchEditingController,
          onChanged: (value) {
            setState(() {
              newsListOnSearch = newsList.where((element) {
                return element.title.toLowerCase().contains(value) ||
                    element.author.toLowerCase().contains(value) ||
                    element.desc.toLowerCase().contains(value) ||
                    element.publishedAt.toLowerCase().contains(value);
              }).toList();
            });
          },
          style: const TextStyle(fontSize: 24),
          cursorColor: const Color(0xff1968b3),
          decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xff1968b3),
                size: 30,
              ),
              hintText: "Search in feed",
              hintStyle: TextStyle(
                  color: Color(0xff1968b3),
                  fontWeight: FontWeight.w500,
                  fontSize: 24)),
        ),
      ),
      body: newsList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      itemCount: searchEditingController.text.isNotEmpty
                          ? newsListOnSearch.length
                          : newsList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: Card(
                            elevation: 5,
                            child: Container(
                              // padding: EdgeInsets.all(10),

                              margin: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        searchEditingController.text.isNotEmpty
                                            ? "${currentDateTime.difference(DateTime.parse(newsListOnSearch[index].publishedAt)).inHours} hours ago ${newsListOnSearch[index].author}"
                                            : "${currentDateTime.difference(DateTime.parse(newsList[index].publishedAt)).inHours} hours ago ${newsList[index].author}",
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      SizedBox(
                                          width: 240,
                                          child: Text(
                                            searchEditingController
                                                    .text.isNotEmpty
                                                ? newsListOnSearch[index].title
                                                : newsList[index].title,
                                            maxLines: 3,
                                            style: const TextStyle(
                                                color: Color(0xff1968b3),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                          width: 260,
                                          child: Text(
                                            searchEditingController
                                                    .text.isNotEmpty
                                                ? newsListOnSearch[index].desc +
                                                    "..."
                                                : newsList[index].desc + "...",
                                            maxLines: 2,
                                            style: const TextStyle(
                                              color: Color(0xff1968b3),
                                              fontSize: 11,
                                            ),
                                          ))
                                    ],
                                  ),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: !hasInternet
                                          ? Image.asset(
                                              'assets/images/no_image.png',
                                              width: 60,
                                              height: 100,
                                              fit: BoxFit.cover)
                                          : Image.network(
                                              newsList[index].urlToImage,
                                              width: 60,
                                              fit: BoxFit.cover,
                                              height: 100,
                                            ))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ]),
    );
  }
}
