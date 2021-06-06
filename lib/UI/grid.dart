import 'package:GridPost2/Data/imagesData.dart';
import 'package:GridPost2/UI/PostView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Grid extends StatefulWidget {
  const Grid({Key key}) : super(key: key);

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PostView()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding : EdgeInsets.all(15),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.red)),
                        width: double.infinity,
                        child: Center(child: 'Tap here to switch to PostView'.text.xl2.red600.makeCentered())
                    ),
                  )
              ),
              Flexible(
                child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                            mainAxisSpacing: MediaQuery.of(context).size.width *0.005,
                            crossAxisSpacing: MediaQuery.of(context).size.width *0.005
                        ),
                        itemCount: snapshot.data.hits.length,
                        itemBuilder: (context, index){
                          return
                            Container(
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data.hits[index].largeImageURL,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator(backgroundColor: Colors.red,)),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              fit: BoxFit.cover
                            ),
                          );
                        }
                      ),
                    )
        ]
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
