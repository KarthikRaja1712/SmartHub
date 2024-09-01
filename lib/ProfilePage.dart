import 'package:flutter/material.dart';
import 'package:sih/components/GradientBackground.dart';
import 'package:sih/components/ProgressCircle.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isNewsletterEnabled = false;
  bool isDarkThemeEnabled = false;
  bool isReminderEnabled = false;
  // Feedback controller
  final TextEditingController feedbackController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors
            .transparent, // Makes sure the Scaffold does not override the gradient
        appBar: AppBar(
          title: Center(
            child: Text(
              'Profile Page',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
          backgroundColor:
              Colors.transparent, // Transparent app bar to see the gradient
          elevation: 0,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                      'https://example.com/your-profile-image.png', // Replace with your profile image URL
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'SmartHub',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Congratulatory card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        child: Image.asset(
                            'assets/medals.png'), // Replace with your image asset
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Congratulations!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Module 1 Completed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Add your 'View All' button functionality here
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 14),
                  child: Text(
                    'Learning Progress',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 22,
                    ),
                  ),
                ),

                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 213, 220, 255),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ProgressCircle(
                          percentage: 68), // Use the ProgressCircle widget
                      Container(
                        //margin: EdgeInsets.only(right: 70),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your next Medal is on the way!',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Complete your video lessons',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  //margin: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SwitchListTile(
                        title: const Text('Newsletter',
                            style: TextStyle(color: Colors.blue, fontSize: 18)),
                        value: isNewsletterEnabled,
                        onChanged: (bool value) {
                          setState(() {
                            isNewsletterEnabled = value;
                          });
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16),
                        child: Text(
                          '(if you enable this option you will get monthly newsletter)',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SwitchListTile(
                        title: const Text('Display Theme',
                            style: TextStyle(color: Colors.blue)),
                        value: isDarkThemeEnabled,
                        onChanged: (bool value) {
                          setState(() {
                            isDarkThemeEnabled = value;
                          });
                        },
                      ),
                      SwitchListTile(
                        title: const Text(
                          'Remind Me',
                          style: TextStyle(
                              color: Colors.blue), // Use a lighter blue color
                        ),
                        dense: false,
                        value: isReminderEnabled,
                        onChanged: (bool value) {
                          setState(() {
                            isReminderEnabled = value;
                          });
                        },
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Text('(through whatsapp)',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                              ))),
                      SizedBox(height: 15),
                      Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Text(
                            'Tutorial',
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 14),
                          child: Text(
                            '(Quick Tour For This App)',
                            style: TextStyle(fontSize: 14, color: Colors.blue),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }
}
