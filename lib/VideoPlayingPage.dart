import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sih/HomePage.dart';
import 'package:sih/word_world_game.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class VideoPlayingPage extends StatefulWidget {
  final String videoAssetPath;
  final String title;
  final String description;
  final String channelName;

  const VideoPlayingPage({
    Key? key,
    required this.videoAssetPath,
    required this.title,
    required this.description,
    required this.channelName,
  }) : super(key: key);

  @override
  _VideoPlayingPageState createState() => _VideoPlayingPageState();
}

class _VideoPlayingPageState extends State<VideoPlayingPage> {
  late VideoPlayerController _controller;
  bool _isFullscreen = false;
  bool _showControls = false; // Controls visibility flag
  List<String> comments = [];
  TextEditingController _commentController = TextEditingController();
  Timer? _hideTimer; // Timer to hide controls after a delay

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoAssetPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // Automatically play the video once initialized
      }).catchError((error) {
        print('Error initializing video: $error');
      });

    _controller.addListener(() {
      setState(() {});
      _checkVideoEnd(); // Check if video has ended
    });

    // Initialize the timer to hide controls after a delay
    _startHideTimer();
  }

  void _checkVideoEnd() {
    // Check if video has ended
    if (_controller.value.position >= _controller.value.duration) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                WordWorldGame()), // Replace with your destination page
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _commentController.dispose();
    _hideTimer?.cancel(); // Cancel the timer if it exists
    super.dispose();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 83, 108, 247),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            height: 80,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: Text("Introduction to Constitution",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ))),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: OrientationBuilder(
              builder: (context, orientation) {
                if (orientation == Orientation.landscape) {
                  return _buildLandscapePlayer();
                } else {
                  return _buildPortraitPlayer();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _isFullscreen
          ? null
          : FloatingActionButton(
              onPressed: () {
                // Action for the floating button
              },
              child: Icon(Icons.bubble_chart),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildLandscapePlayer() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(_controller),
                  _buildHoverControls(),
                ],
              ),
            )
          : CircularProgressIndicator(),
    );
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
      if (_isFullscreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: SystemUiOverlay.values);
      }
    });
  }

  Widget _buildPortraitPlayer() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                        children: [
                          VideoPlayer(_controller),
                          _buildHoverControls(),
                        ],
                      ),
                    )
                  : Container(
                      height: 200, // Placeholder height while video loads
                      color: Colors.black,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.channelName,
              style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.description),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Other Videos',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              padding: EdgeInsets.all(10), child: _buildOtherVideosSection()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Comments',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          _buildCommentSection(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Links',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          _buildLinkSection(),
        ],
      ),
    );
  }

  Widget _buildHoverControls() {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _showControls = true;
          _startHideTimer(); // Restart the timer when mouse enters
        });
      },
      onExit: (_) {
        _startHideTimer(); // Hide controls after delay when mouse exits
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            _showControls = !_showControls; // Toggle controls on tap
          });
        },
        child: AnimatedOpacity(
          opacity: _showControls ? 1.0 : 0.0,
          duration: Duration(milliseconds: 300),
          child: Container(
            color: Colors.black54,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.fast_rewind,
                          size: 30, color: Colors.white),
                      onPressed: () {
                        _controller.seekTo(
                            _controller.value.position - Duration(seconds: 10));
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 50,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.fast_forward,
                          size: 30, color: Colors.white),
                      onPressed: () {
                        _controller.seekTo(
                            _controller.value.position + Duration(seconds: 10));
                      },
                    ),
                  ],
                ),
                Container(
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: _buildVideoSlider(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoSlider() {
    return Row(
      children: [
        Text(
          _formatDuration(_controller.value.position),
          style: TextStyle(color: Colors.white),
        ),
        Expanded(
          child: Slider(
            value: _controller.value.position.inSeconds.toDouble(),
            min: 0.0,
            max: _controller.value.duration.inSeconds.toDouble(),
            onChanged: (value) {
              // Update video position without rebuilding the widget
              _controller.seekTo(Duration(seconds: value.toInt()));
            },
            onChangeStart: (value) {
              // Pause video while seeking
              if (_controller.value.isPlaying) {
                _controller.pause();
              }
            },
            onChangeEnd: (value) {
              // Resume video after seeking is complete
              if (!_controller.value.isPlaying) {
                _controller.play();
              }
            },
          ),
        ),
        Text(
          _formatDuration(_controller.value.duration),
          style: TextStyle(color: Colors.white),
        ),
        IconButton(
          padding: EdgeInsets.only(bottom: 10),
          icon: Icon(
            _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
            color: Colors.white,
          ),
          onPressed: _toggleFullscreen,
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  Widget _buildOtherVideosSection() {
    return Container(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildVideoThumbnail('Video 1', 'assets/thumbnail.png'),
          _buildVideoThumbnail('Video 2', 'assets/thumbnail.png'),
          _buildVideoThumbnail('Video 3', 'assets/thumbnail.png'),
          _buildVideoThumbnail('Video 4', 'assets/thumbnail.png'),
        ],
      ),
    );
  }

  Widget _buildVideoThumbnail(String title, String assetPath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(assetPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildCommentSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _commentController,
            decoration: InputDecoration(
              hintText: 'Enter your comment',
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  setState(() {
                    comments.add(_commentController.text);
                    _commentController.clear();
                  });
                },
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(comments[index]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLinkSection() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: links.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.link),
          title: Text('Link ${index + 1}'),
          onTap: () {
            _launchURL(links[index]);
          },
        );
      },
    );
  }
}

Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}

List<String> links = [
  "https://en.wikipedia.org/wiki/Constitution",
  "https://en.wikipedia.org/wiki/Constitution_of_India",
  "https://en.wikipedia.org/wiki/Constitution",
  "https://en.wikipedia.org/wiki/Constitution_of_India",
  "https://en.wikipedia.org/wiki/Constitution",
];
