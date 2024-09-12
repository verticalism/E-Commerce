import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vetore/activity/mainPage.dart';
import 'package:vetore/activity/productReviewPage.dart';
import 'package:vetore/getAPI/getCoffeAPI.dart';
import 'package:vetore/model/fakestoreapimodel.dart';
import 'package:image_card/image_card.dart';

class GridViewProductAPI extends StatelessWidget {
  const GridViewProductAPI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: double.infinity),
      child: FutureBuilder<List<Item>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                padding: EdgeInsets.all(10),
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
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.52,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return ImageCard(product: product);
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final Item product;
  const ImageCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductReviewPage(
                      productTitle: product.title,
                      productTitleDesc: product.description,
                      imageUrl: product.imageUrl,
                      price: product.price,
                      rate: product.rate,
                    )));
      },
      child: TransparentImageCard(
        width: 200,
        imageProvider: CachedNetworkImageProvider(
          product.imageUrl,
        ),
        tags: [RoundedOutlinedButton(categoryName: product.category)],
        title: Text(
          product.title,
          maxLines: 2,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        description: Text(
          style: TextStyle(color: Colors.white),
          product.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class PageViewImage extends StatefulWidget {
  final List<Item> product;
  PageViewImage({super.key, required this.product});

  @override
  State<PageViewImage> createState() => _PageViewImageState();
}

class _PageViewImageState extends State<PageViewImage> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.product.length,
      pageSnapping: true,
      itemBuilder: (context, pagePosition) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Image.network(widget.product[pagePosition].imageUrl),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Item product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                filterQuality: FilterQuality.medium,
                fit: BoxFit.fitWidth,
                height: 120,
                width: double.infinity,
                placeholder: (context, url) => Center(
                  child: Text(
                    "Loading...",
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline_sharp,
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Image not load up, Try Again"),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        height: 2),
                  ),
                  TextButton(
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductReviewPage(
                                          productTitle: product.title,
                                          productTitleDesc: product.description,
                                          imageUrl: product.imageUrl,
                                          price: product.price,
                                          rate: product.rate,
                                        )))
                          },
                      child: Text("BUY"),
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              height: 2),
                        ),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      )),
                ],
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                Text("${product.rate}")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
