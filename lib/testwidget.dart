import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Text("data"),
            ListView(
              scrollDirection: Axis.horizontal,
              children: [Text("data"), Text("data")],
            )
          ],
        ),
      ),
    );
  }
}
