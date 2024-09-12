import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vetore/activity/productReviewPage.dart';
import 'package:vetore/getAPI/getCoffeAPI.dart';

class ImageSliderWidget extends StatelessWidget {
  final bool isAutoPlay;
  const ImageSliderWidget({
    super.key,
    required this.isAutoPlay,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Column(
              children: [
                Icon(
                  Icons.sms_failed_outlined,
                  color: Colors.red[500],
                ),
                Text('No products found'),
              ],
            ));
          }
          final product = snapshot.data;
          return ClipRRect(
            child: CarouselSlider(
              options: CarouselOptions(
                  height: 200,
                  autoPlay: isAutoPlay,
                  autoPlayInterval: Duration(seconds: 5)),
              items: product!.map((item) {
                String limitedTitle = item.title.substring(0, 15) + "...";
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductReviewPage(
                                  productTitle: item.title,
                                  productTitleDesc: item.description,
                                  imageUrl: item.imageUrl,
                                  price: item.price,
                                  rate: item.rate),
                            ));
                      },
                      child: Container(
                        width: double
                            .infinity, // MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Color.fromARGB(
                                  255, 0, 0, 0), // Transparent black at top
                              Color.fromARGB(
                                  255, 50, 50, 50), // Solid black at bottom
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: item.imageUrl,
                                width: double.infinity,
                                height: 200,
                                fadeInDuration: Duration(milliseconds: 200),
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${limitedTitle}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textWidthBasis:
                                          TextWidthBasis.longestLine,
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 2.0,
                                              offset: Offset(2.0, 2.0))
                                        ],
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '\$${item.price}',
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              blurRadius: 2.0,
                                              offset: Offset(2.0, 2.0))
                                        ],
                                        color: Colors.greenAccent,
                                        fontSize: 20.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
        },
        future: fetchProducts());
  }
}
