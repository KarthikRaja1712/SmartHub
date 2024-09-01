import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih/HomePage.dart';
import 'package:sih/ProfilePage.dart';
import 'package:sih/VideoPage.dart';
import 'package:sih/components/GradientBackground.dart';
import 'package:sih/components/card.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures that Flutter binding is initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0; // Current index of the bottom navigation bar

  final List<Widget> _pages = [
    // List of pages to navigate to
    Page1(),
    VideoPage(),
    HomePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the index on item tap
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Current selected index
        onTap: _onItemTapped, // Function to handle tap events
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_fill_outlined),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad_outlined),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue, // Color for the selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
        type: BottomNavigationBarType.fixed, // To keep icons fixed in position
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Stack(
        children: [
          ListView(
            children: [
              Container(
                margin: EdgeInsets.all(30),
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //   width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Hello, Student',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )),
                          Text(
                            "Lets learn something new today",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Icon(Icons.notification_add),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 35,
                  width: double.infinity,
                  color: Color.fromARGB(255, 74, 103, 255),
                  alignment: Alignment.center,
                  child: Text(
                    "BLAH BLAH BLAH BLAH BLAH",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  "Latest Updates",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Articles",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Container(
                height: 250,
                child: Container(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CustomCard(
                          title: "Supreme Court Upholds",
                          Category: "Read Now",
                          imageurl:
                              // "data:image/jpeg;base64,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"),
                              "https://blog.ipleaders.in/wp-content/uploads/2019/01/Fraud.jpg"),
                      CustomCard(
                          title: "Supreme Court Upholds",
                          Category: "Read Now",
                          imageurl:
                              //        "data:image/jpeg;base64,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"),
                              "https://blog.ipleaders.in/wp-content/uploads/2019/01/Fraud.jpg"),
                      CustomCard(
                          title: "Supreme Court Upholds",
                          Category: "Read Now",
                          imageurl:
                              "https://blog.ipleaders.in/wp-content/uploads/2019/01/Fraud.jpg")
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Videos",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              CustomCard2(
                  title: "Constitutional Amendment",
                  Category: "WATCH NOW",
                  imageurl:
                      "https://i0.wp.com/cjp.org.in/wp-content/uploads/2020/08/Supreme_court_feature_image_03.jpg?fit=1020%2C534&ssl=1"),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  "Newly Added Videos",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              CustomCard2(
                  title: "Constitutional Amendment",
                  Category: "WATCH NOW ",
                  imageurl:
                      "https://i0.wp.com/cjp.org.in/wp-content/uploads/2020/08/Supreme_court_feature_image_03.jpg?fit=1020%2C534&ssl=1"),
              CustomCard2(
                  title: "Constitutional Amendment",
                  Category: "WATCH NOW ",
                  imageurl:
                      "https://i0.wp.com/cjp.org.in/wp-content/uploads/2020/08/Supreme_court_feature_image_03.jpg?fit=1020%2C534&ssl=1"),
              CustomCard2(
                  title: "Constitutional Amendment",
                  Category: "WATCH NOW ",
                  imageurl:
                      "https://i0.wp.com/cjp.org.in/wp-content/uploads/2020/08/Supreme_court_feature_image_03.jpg?fit=1020%2C534&ssl=1"),
              CustomCard2(
                  title: "Constitutional Amendment",
                  Category: "WATCH NOW ",
                  imageurl:
                      "https://i0.wp.com/cjp.org.in/wp-content/uploads/2020/08/Supreme_court_feature_image_03.jpg?fit=1020%2C534&ssl=1"),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: Container(
              child: Image.asset("assets/bot.png"),
            ),
          ),
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Search Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Notifications Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
