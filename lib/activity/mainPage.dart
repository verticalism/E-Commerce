import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vetore/activity/productPage.dart';
import 'package:vetore/activity/profile.dart';
import 'package:vetore/widgets/GridViewProduct.dart';
import 'package:vetore/widgets/drawer_widget.dart';
import 'package:vetore/widgets/image_slider_widget.dart';

class Controller extends StatelessWidget {
  const Controller({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List widgetLists = [MyProductPage(), ProductPageScreen(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56), child: AppBarWidget()),
      body: widgetLists[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: HexColor("#ECB176"),
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: "Product"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined), label: "Profile"),
        ],
      ),
      drawer: DrawerWidget(),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      actions: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.account_balance_wallet_outlined))
      ],
      title: Text(
        "Vetore",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MyProductPage extends StatefulWidget {
  const MyProductPage({super.key});

  @override
  State<MyProductPage> createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.black,
          child: ListView(scrollDirection: Axis.vertical, children: [
            ImageSliderWidget(
              isAutoPlay: true,
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                "Products",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            GridViewProductAPI()
          ])),
    );
  }
}

class RoundedOutlinedButton extends StatelessWidget {
  const RoundedOutlinedButton({
    required this.categoryName,
  });

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: OutlinedButton(
        onPressed: () {},
        child: Container(child: Text(categoryName)),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(8),
          backgroundColor: HexColor("#ECB176"),
          foregroundColor: Colors.black,
          side: BorderSide(width: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                10.0), // 25% of the button's height or width
          ),
        ),
      ),
    );
  }
}
