import 'dart:ui';

import 'package:GridPost2/Data/imagesData.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'grid.dart';

class PostView extends StatefulWidget {
  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  Future<ImagesData> future;
  @override
  void initState() {
    future = fetchImageData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(child: 'GridView'.text.bold.red600.make())
        ),
        body: FutureBuilder<ImagesData>(
            future: fetchImageData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Grid()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              padding : EdgeInsets.all(15),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.red)),
                              width: double.infinity,
                              child: Center(child: 'Tap here to switch to GridView'.text.xl2.red600.makeCentered())
                          ),
                        )
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.hits.length,
                        itemBuilder: (context,index)=> Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.only(top: 20, right: 20, bottom: 15, left: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(15),
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: Offset(0, 1),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data.hits[index].userImageURL,
                                      placeholder: (context, url) => Center(child: CircularProgressIndicator(backgroundColor: Colors.red,)),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                      height: MediaQuery.of(context).size.height * 0.05,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data.hits[index].user,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          softWrap: false,
                                          style: TextStyle(fontSize: 17,color: Colors.black),
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              CachedNetworkImage(
                                imageUrl: snapshot.data.hits[index].largeImageURL,
                                placeholder: (context, url) => Center(child: CircularProgressIndicator(backgroundColor: Colors.red,)),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.heart,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () {},
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      CupertinoIcons.bookmark,
                                      color: Colors.black54,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return Center(child: CircularProgressIndicator());
            }
        )
    );
  }
}
