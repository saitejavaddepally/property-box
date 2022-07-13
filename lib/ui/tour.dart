import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:property_box/components/neumorphic_image_buttom.dart';
import 'package:video_player/video_player.dart';

import '../components/neu_circular_button.dart';
import '../theme/colors.dart';

class Tour extends StatefulWidget {
  const Tour({Key? key}) : super(key: key);

  @override
  State<Tour> createState() => _TourState();
}

class _TourState extends State<Tour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.dark,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.keyboard_backspace_rounded,
                          color: Colors.white)),
                  GestureDetector(
                      onTap: () {},
                      child:
                          const Icon(Icons.share_outlined, color: Colors.white))
                ],
              ),
              const SizedBox(height: 30),
              Text(
                  '150 Sq.yards  G+1 House at SaiNagar, LB Nagar for 7000000'
                      .toLowerCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      letterSpacing: -0.15,
                      color: Colors.white.withOpacity(0.87))),
              const SizedBox(height: 20),
              Flexible(
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        var videoLink =
                            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';

                        return VideoPlayPage(videoLink: videoLink);
                      }))
            ]),
          ),
        ));
  }
}

class VideoPlayPage extends StatefulWidget {
  final String videoLink;
  const VideoPlayPage({required this.videoLink, Key? key}) : super(key: key);

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoLink);
    _initializeVideoPlayerFuture = _controller.initialize();
    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Neumorphic(
              padding: const EdgeInsets.all(7),
              style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  color: CustomColors.dark,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  shadowLightColor: Colors.black),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: HexColor('1C1C1C')),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // If the video is playing, pause it.
                            if (_controller.value.isPlaying) {
                              setState(() {
                                _controller.pause();
                              });
                            }
                          },
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: VideoPlayer(_controller)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Expanded(
                              child: Text('Drawing room overview',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Colors.white,
                                      letterSpacing: -0.15)),
                            ),
                            NeumorphicImageButton(image: 'assets/download.png'),
                            SizedBox(width: 10),
                            NeumorphicImageButton(image: 'assets/notific.png'),
                          ],
                        )
                      ],
                    ),
                    if (!_controller.value.isPlaying)
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _controller.play();
                                  });
                                },
                                child: Image.asset("assets/play.png"))),
                      ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
