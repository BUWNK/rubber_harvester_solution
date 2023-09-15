import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rubberx/NewsShoppingChat/news_updates_view.dart';

import 'Models/news_model.dart';

class NewsUpdate extends StatefulWidget {
  const NewsUpdate({super.key});

  @override
  State<NewsUpdate> createState() => _NewsUpdateState();
}

class _NewsUpdateState extends State<NewsUpdate> {
  String imgString =
      "https://firebasestorage.googleapis.com/v0/b/rubberx-f3daf.appspot.com/o/news%2Frubber.png?alt=media&token=fb463525-18ab-401e-b139-a450bef6ae71";

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<NewsModel> newsModel = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('news').get();

      List<NewsModel> fetchedNews = [];
      for (var document in querySnapshot.docs) {
        fetchedNews.add(NewsModel.fromMap(document.data()));
      }

      setState(() {
        newsModel = fetchedNews;
        log(newsModel.toString());
      });
    } catch (e) {
      log("Error fetching news: $e");
    }
  }

  Widget newsCard(NewsModel newsModel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsUpdateView(
                      newsModel: newsModel,
                    )));
      },
      child: SizedBox(
        // height: 150,
        child: Card(
          color: const Color.fromRGBO(19, 19, 19, 1.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.network(
                  newsModel.image,
                  width: 100,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      newsModel.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              newsModel.author,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              newsModel.date,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Latest News',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // const Text(
            //   'No news updates available',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 18,
            //   ),
            // ),
            // newsCard("title", "description", "author", "date", imgString2),
            Column(
              children: newsModel.map((news) {
                return newsCard(news);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
