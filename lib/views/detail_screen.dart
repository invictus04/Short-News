import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inshorts/services/news_service.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/news_model.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  final String selectedCategory;

  const DetailScreen(this.index, this.selectedCategory, {super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  News? news;
  var isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    news = await NewsService().getAllNews(widget.selectedCategory);
    if (news != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news?.category.toUpperCase() ?? 'No category'),
        centerTitle: true,
      ),
      body:
          news?.data != null
              ? SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      news?.data[widget.index].title ?? 'No Title',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            news?.data[widget.index].imageUrl ?? 'No Image Url',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            news?.data[widget.index].author ?? 'No Author',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            news?.data[widget.index].time ?? 'No Time',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        news?.data[widget.index].content ?? "No Content",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        launchUrl(
                          Uri.parse(
                            news?.data[widget.index].readMoreUrl ??
                                'https://www.google.com',
                          ),
                        );
                      },
                      child: Text(
                        'Read More ....',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              )
              :  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.white,
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.white,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.white,
                        child: Container(
                          height: 20,
                          width: 100,
                          color: Colors.white,
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.white,
                        child: Container(
                          height: 20,
                          width: 80,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.white,
                    child: Column(
                      children: List.generate(
                        5,
                            (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Container(
                            height: 20,
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.white,
                    child: Container(
                      height: 40,
                      width: 150,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
