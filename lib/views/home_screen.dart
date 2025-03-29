import 'package:flutter/material.dart';
import 'package:inshorts/services/news_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/news_model.dart';
import 'detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  News? news;
  var isLoaded = false;
  String selectedCategory = "all";

  var categories = [
    "all",
    "national",
    "business",
    "sports",
    "world",
    "politics",
    "technology",
    "startup",
    "entertainment",
    "miscellaneous",
    "hatke",
    "science",
    "automobile",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    news = await NewsService().getAllNews(selectedCategory);
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
        actions: [
          Text(
            '${news?.category == "all" ? news?.category.substring(0, 3).toUpperCase() : news?.category.substring(0, 5).toUpperCase()}',
          ),
          SizedBox(width: 20),
        ],
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "SHORT",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "NEWS",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),

      drawer: Drawer(
        surfaceTintColor: Colors.grey.shade200,
        shadowColor: Colors.grey.shade200,
        elevation: 4.0,
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "SHORT",
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "NEWS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemCount: categories.length,
              itemBuilder:
                  (context, index) => TextButton(
                    onPressed: () {
                      selectedCategory = categories[index];
                      getData();
                      Navigator.pop(context);
                    },
                    child: Text(
                      categories[index].toUpperCase(),
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                    ),
                  ),
              shrinkWrap: true,
            ),
          ],
        ),
      ),

      body:
          news?.data != null
              ? RefreshIndicator(
                backgroundColor: Colors.white,
                color: Colors.green,
                onRefresh: () => getData(),
                child: ListView.builder(
                  itemCount: news?.data.length,
                  itemBuilder:
                      (context, index) => ListTile(
                        title: Text(
                          news?.data[index].title ?? 'No Title',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(news?.data[index].author ?? 'No Author'),
                        leading: CachedNetworkImage(
                          imageUrl:
                              news?.data[index].imageUrl ?? 'No Image Url',
                          fit: BoxFit.cover,
                          width: 110,
                          height: 110,
                        ),
                        trailing: Text(news?.data[index].time ?? 'No Time'),
                        titleAlignment: ListTileTitleAlignment.titleHeight,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      DetailScreen(index, selectedCategory),
                            ),
                          );
                        },
                      ),
                ),
              )
              : ListView.builder(
                itemCount: 6,
                itemBuilder:
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 20,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 100,
                                    height: 20,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 50,
                                    height: 20,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
    );
  }
}
