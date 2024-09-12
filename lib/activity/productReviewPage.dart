import 'package:cached_network_image/cached_network_image.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vetore/widgets/image_slider_widget.dart';

class ProductReviewPage extends StatelessWidget {
  const ProductReviewPage({
    super.key,
    required this.productTitle,
    required this.productTitleDesc,
    required this.imageUrl,
    required this.price,
    required this.rate,
  });

  final String imageUrl;
  final String productTitle;
  final String productTitleDesc;
  final double price;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          "$productTitle",
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(children: [
            ImageSection(image: imageUrl),
            TitleSection(
              productPrice: price,
              productTitle: productTitle,
              productTitleDesc: productTitleDesc,
              productRate: rate,
            ),
            ButtonSection(),
            TextSection(description: productTitleDesc),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Recommended For You",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ImageSliderWidget(
                isAutoPlay: false,
              ),
            )
          ]),
        ),
      ),
      bottomNavigationBar:
          BottomNavigationBarProductReview(price: price, imageUrl: imageUrl),
    );
  }
}

class BottomNavigationBarProductReview extends StatelessWidget {
  const BottomNavigationBarProductReview({
    super.key,
    required this.price,
    required this.imageUrl,
  });

  final double price;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: Container(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Price",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${price}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                    print("get to link");
                    launchUrlString(imageUrl);
                    // launchUrlString(
                    //     "https://stackoverflow.com/questions/43583411/how-to-create-a-hyperlink-in-flutter-widget");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("#C38154")),
                  child: Text(
                    'Buy Now',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection(
      {super.key,
      required this.productTitle,
      required this.productTitleDesc,
      required this.productPrice,
      required this.productRate});

  final String productTitle;
  final String productTitleDesc;
  final double productPrice;
  final double productRate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$${productPrice}',
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                child: Text(
                  productTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Text(
                productTitleDesc,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[500]),
              ),
            ],
          )),
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text(
            "${productRate}",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ButtonWithText(color: color, icon: Icons.call, label: "CALL"),
          ButtonWithText(color: color, icon: Icons.near_me, label: "ROUTE"),
          ButtonWithText(color: color, icon: Icons.share, label: "SHARE")
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: color,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w400, color: color),
          ),
        )
      ],
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(
        description,
        style: TextStyle(color: Colors.white),
        softWrap: true,
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: image,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error),
                SizedBox(height: 8),
                Text("Image not load up, pleas try again")
              ],
            ),
          ),
          width: 600,
          height: 240,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
