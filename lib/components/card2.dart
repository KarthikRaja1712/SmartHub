import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String Category;
  final String imageurl;

  const CustomCard({
    Key? key,
    required this.title,
    required this.Category,
    required this.imageurl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 200,
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image(
                height: 200,
                width: double.infinity,
                image: NetworkImage(imageurl),
                fit: BoxFit.cover,
              ),
            ),
            Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black87,
                      Colors.transparent
                    ], // Gradient colors
                    begin: Alignment.topCenter, // Starting point
                    end: Alignment.bottomCenter, // Ending point
                  ),
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                )),
            Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.only(top: 160),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      Category,
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
