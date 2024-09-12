import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 65, 65, 65),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 31, 30, 30),
              ),
              duration: Duration(milliseconds: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    title: Text("Name of user"),
                    leading: Icon(Icons.supervised_user_circle),
                  ),
                  ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    title: Text("ID : 20129412"),
                    leading: Icon(Icons.credit_card_outlined),
                  )
                ],
              )),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            title: Text("Exit"),
            leading: Icon(Icons.login_outlined),
            onTap: () {
              SystemNavigator.pop();
            },
          )
        ],
      ),
    );
  }
}
