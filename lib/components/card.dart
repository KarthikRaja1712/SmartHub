import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      width: 390,
      decoration: BoxDecoration(),
      //       borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
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
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                )),
            Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.only(top: 160),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 20),
                      child: Text(
                        Category,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 20),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class CustomCard2 extends StatelessWidget {
  final String title;
  final String Category;
  final String imageurl;

  const CustomCard2({
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
      width: 390,
      decoration: BoxDecoration(),
      //        borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
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
                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  overflow: TextOverflow.ellipsis,
                )),
            Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.only(top: 160),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Category,
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )
                  ],
                )),
            Positioned(
                top: 60,
                left: 130,
                child: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/16/16630.png",
                  height: 80,
                )),
          ],
        ),
      ),
    );
  }
}
