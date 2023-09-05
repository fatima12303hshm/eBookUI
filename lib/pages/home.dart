// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List? popBooks;
  List? Books;
  double? _deviceWidth, _deviceHeight;

  ScrollController? _scrollController;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    ReadData();
  }

  void ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString('assets/json/PopularBooks.json')
        .then((s) {
      setState(() {
        popBooks = json.decode(s);
      });
    });
    await DefaultAssetBundle.of(context)
        .loadString('assets/json/books.json')
        .then((s) {
      setState(() {
        Books = json.decode(s);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Popular Books",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 180,
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    left: -40,
                    right: 0,
                    child: Container(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 180),
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount: popBooks?.length ?? 0,
                            itemBuilder: (_, i) {
                              return Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(popBooks![i]["img"]),
                                  ),
                                ),
                                margin: const EdgeInsets.only(right: 10),
                              );
                            }),
                      ),
                    ),
                  )
                ]),
              ),
              Expanded(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll) {
                    return [
                      SliverAppBar(
                        backgroundColor: Color(0xFFfafafc),
                        pinned: true,
                        bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(50),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: TabBar(
                                indicatorPadding: const EdgeInsets.all(0),
                                indicatorSize: TabBarIndicatorSize.label,
                                labelPadding: const EdgeInsets.only(right: 5),
                                controller: _tabController,
                                isScrollable: true,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 7,
                                          offset: Offset(0, 0))
                                    ]),
                                tabs: [
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 7,
                                              offset: Offset(0, 0))
                                        ]),
                                    height: 50,
                                    width: 120,
                                    child: const Text(
                                      "New",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.red[400],
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 7,
                                              offset: Offset(0, 0))
                                        ]),
                                    height: 50,
                                    width: 120,
                                    child: const Text(
                                      "Popular",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 7,
                                              offset: Offset(0, 0))
                                        ]),
                                    height: 50,
                                    width: 120,
                                    child: const Text(
                                      "Trending",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                          itemCount: Books == null ? 0 : Books!.length,
                          itemBuilder: (_, i) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFfdfdfd),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 0.2,
                                          offset: Offset(0, 0),
                                          color: Colors.grey.withOpacity(0.2)),
                                    ]),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image:
                                                  AssetImage(Books![i]["img"]),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              Text(
                                                Books![i]["rating"],
                                                style: TextStyle(
                                                    color: Colors.amber),
                                              )
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8)),
                                          Text(Books![i]["title"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16)),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8)),
                                          Text(Books![i]["text"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8)),
                                          Container(
                                            width: 60,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Love",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      ListView.builder(
                          itemCount: Books == null ? 0 : Books!.length,
                          itemBuilder: (_, i) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFfdfdfd),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 0.2,
                                          offset: Offset(0, 0),
                                          color: Colors.grey.withOpacity(0.2)),
                                    ]),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image:
                                                  AssetImage(Books![i]["img"]),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              Text(
                                                Books![i]["rating"],
                                                style: TextStyle(
                                                    color: Colors.amber),
                                              )
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8)),
                                          Text(Books![i]["title"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16)),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8)),
                                          Text(Books![i]["text"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8)),
                                          Container(
                                            width: 60,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Love",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      ListView.builder(
                          itemCount: Books == null ? 0 : Books!.length,
                          itemBuilder: (_, i) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFfdfdfd),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 0.2,
                                          offset: Offset(0, 0),
                                          color: Colors.grey.withOpacity(0.2)),
                                    ]),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image:
                                                  AssetImage(Books![i]["img"]),
                                            )),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              Text(
                                                Books![i]["rating"],
                                                style: TextStyle(
                                                    color: Colors.amber),
                                              )
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8)),
                                          Text(Books![i]["title"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16)),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8)),
                                          Text(Books![i]["text"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                  fontSize: 12)),
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 8)),
                                          Container(
                                            width: 60,
                                            height: 20,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Love",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget AppBar() {
    Size size = Size(_deviceWidth!, _deviceHeight! * 0.1);
    return PreferredSize(
        preferredSize: size,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.window,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Icon(
                    Icons.notifications_active,
                    color: Colors.black,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
