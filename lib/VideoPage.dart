import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih/VideoPlayingPage.dart';

import 'components/GradientBackground.dart';

class VideoPage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 83, 108, 247),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                height: 80,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text("Constitution Overview",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.collections,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Center(
                  child: SizedBox(
                      height: 30,
                      child: Text(
                        'Module 1',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ))),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to video playing page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayingPage(
                            // with actual video URL
                            title: 'Introduction to Constitution ',
                            description: 'This is the description of video .',
                            channelName: 'Module1 ',
                            videoAssetPath: 'assets/video.mp4',
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/thumbnail.png', // Path to your image asset
                                fit: BoxFit
                                    .cover, // Ensure the image covers the entire container
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Introduction to Constitution',
                              style: TextStyle(fontSize: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(Icons.check_circle,
                              color: Colors.green, size: 24),
                        ],
                      ),
                    ),
                  );
                },
                childCount: 1,
              ),
            )
          ],
        ),

        floatingActionButtonLocation:
            FloatingActionButtonLocation.endFloat, // Move to bottom right
      ),
    );
  }
}
