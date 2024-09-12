import 'package:flutter/material.dart';
import 'package:vetore/activity/productReviewPage.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      body: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            ImageSection(
                image:
                    "https://img.freepik.com/premium-photo/trees-growing-forest_1048944-30368869.jpg?w=740"),
            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              title: Text("user2242sa24"),
              leading: Icon(Icons.person),
            ),
            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              title: Text("201025991205"),
              leading: Icon(Icons.credit_card),
            ),
            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              title: Text("user12345@gmail.comr"),
              leading: Icon(Icons.email),
            ),
            ListTile(
              textColor: Colors.white,
              iconColor: Colors.white,
              title: Text("location of user"),
              subtitle: Text(
                  "my location is on the some city with like another that have tree in edge of house"),
              leading: Icon(Icons.location_on_outlined),
            )
          ],
        ),
      ),
    );
  }
}
