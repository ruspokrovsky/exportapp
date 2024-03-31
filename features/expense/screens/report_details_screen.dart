import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ReportDetailsScreen extends StatefulWidget {
  static const routeName = '/reportDetailsScreen';
  List<dynamic> imageList;

  ReportDetailsScreen({Key? key, required this.imageList}) : super(key: key);

  @override
  State<ReportDetailsScreen> createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.imageList);
    return Scaffold(
        appBar: AppBar(),
        body: CarouselSlider(
          items: widget.imageList.map(
                (i) {
              return Builder(
                builder: (BuildContext context) => Image.network(
                  i,
                  fit: BoxFit.contain,
                  height: 200,
                ),
              );
            },
          ).toList(),
          options: CarouselOptions(
            viewportFraction: 1,
            height: double.infinity,
            //autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            enableInfiniteScroll: true,
          ),
        ),
    );
  }

  Widget myWidget(BuildContext context,imageList) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: imageList.length,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(imageList[index]);
            }
        ),
      ),
    );
  }
}
